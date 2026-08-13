from flask import Flask, render_template, request, redirect, url_for, flash, session
import sqlite3
from datetime import datetime

app = Flask(__name__)
app.secret_key = "kunci_rahasia_toko_it"

def get_db_connection():
    conn = sqlite3.connect("toko_it.db")
    conn.row_factory = sqlite3.Row
    return conn

@app.route("/")
def index():
    return redirect(url_for("login"))

@app.route("/login", methods=["GET", "POST"])
def login():
    error = None
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        if username == "admin" and password == "rahasia":
            session["keranjang"] = []
            return redirect(url_for("halaman_kasir"))
        else:
            error = "Login Gagal! Username atau password salah."
    return render_template("login.html", error=error)

@app.route("/kasir", methods=["GET", "POST"])
def halaman_kasir():
    conn = get_db_connection()
    
    if request.method == "POST":
        produk_id = request.form.get("produk_id")
        jumlah_str = request.form.get("jumlah") or request.form.get("qty")
        
        if "keranjang" not in session:
            session["keranjang"] = []
            
        if produk_id and jumlah_str:
            jumlah = int(jumlah_str)
            produk = conn.execute("SELECT * FROM produk WHERE id = ?", (produk_id,)).fetchone()
            
            if p := produk:
                if p["stok"] >= jumlah:
                    subtotal = p["harga"] * jumlah
                    keranjang_item = {
                        "id": p["id"],
                        "nama_produk": p["nama_produk"],
                        "harga": p["harga"],
                        "qty": jumlah,
                        "subtotal": subtotal
                    }
                    daftar_belanja = session["keranjang"]
                    daftar_belanja.append(keranjang_item)
                    session["keranjang"] = daftar_belanja
                
        return redirect(url_for("halaman_kasir"))

    produk_list = conn.execute("SELECT * FROM produk").fetchall()
    conn.close()
    
    if "keranjang" not in session:
        session["keranjang"] = []
        
    total_tagihan = sum(item["subtotal"] for item in session["keranjang"])
    return render_template("kasir.html", produk=produk_list, keranjang=session["keranjang"], total_tagihan=total_tagihan)

@app.route("/simpan-transaksi", methods=["POST"])
def simpan_transaksi():
    if "keranjang" not in session or len(session["keranjang"]) == 0:
        return redirect(url_for("halaman_kasir"))
        
    conn = get_db_connection()
    waktu_sekarang = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    diskon_str = request.form.get("diskon") or request.form.get("diskon_toko")
    diskon_persen = int(diskon_str) if diskon_str else 0
    
    try:
        nota_id = datetime.now().strftime("%Y%m%d%H%M%S")
        
        for item in session["keranjang"]:
            potongan = item["subtotal"] * (diskon_persen / 100)
            total_akhir = int(item["subtotal"] - potongan)
            
            conn.execute("INSERT INTO transaksi (produk_id, jumlah, total_harga, tanggal) VALUES (?, ?, ?, ?)", (item["id"], item["qty"], total_akhir, waktu_sekarang))
            conn.execute("UPDATE produk SET stok = stok - ? WHERE id = ?", (item["qty"], item["id"]))
            
        conn.commit()
        
        # MENGGANTI 'items' MENJADI 'daftar_barang' AGAR AMAN
        session["nota_terakhir"] = {
            "nomor_nota": nota_id,
            "waktu": waktu_sekarang,
            "daftar_barang": session["keranjang"],
            "diskon": diskon_persen
        }
        
        session["keranjang"] = []
        return redirect(url_for("cetak_nota"))
        
    except Exception as e:
        conn.rollback()
        return redirect(url_for("halaman_kasir"))
    finally:
        conn.close()

@app.route("/nota")
def cetak_nota():
    if "nota_terakhir" not in session:
        return "Tidak ada riwayat transaksi.", 404
        
    data_nota = session["nota_terakhir"]
    
    # Menghitung subtotal menggunakan kata kunci baru
    subtotal_kotor = sum(barang["subtotal"] for barang in data_nota["daftar_barang"])
    total_potongan = subtotal_kotor * (data_nota["diskon"] / 100)
    total_bersih = int(subtotal_kotor - total_potongan)
    
    return render_template("nota.html", nota=data_nota, subtotal=subtotal_kotor, potongan=total_potongan, total=total_bersih)

def init_db():
    conn = sqlite3.connect("toko_it.db")
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS produk (id INTEGER PRIMARY KEY AUTOINCREMENT, nama_produk TEXT NOT NULL, harga INTEGER NOT NULL, stok INTEGER NOT NULL)")
    cursor.execute("CREATE TABLE IF NOT EXISTS transaksi (id INTEGER PRIMARY KEY AUTOINCREMENT, produk_id INTEGER NOT NULL, jumlah INTEGER NOT NULL, total_harga INTEGER NOT NULL, tanggal TEXT NOT NULL, FOREIGN KEY (produk_id) REFERENCES produk (id))")
    cursor.execute("SELECT COUNT(*) FROM produk")
    if cursor.fetchone() == 0:
        cursor.executemany("INSERT INTO produk (nama_produk, harga, stok) VALUES (?, ?, ?)", [("Mouse Logi", 50000, 20), ("Keyboard RGB", 120000, 15), ("Monitor LED", 1200000, 8)])
    conn.commit()
    conn.close()

if __name__ == "__main__":
    init_db()
    app.run(debug=True)
