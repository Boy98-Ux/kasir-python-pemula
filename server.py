from flask import Flask, render_template, request, redirect
import sqlite3
from datetime import datetime

app = Flask(__name__)

# Fungsi untuk membuat tabel dan memasukkan data ke database toko_it.db
def simpan_ke_db(total):
    conn = sqlite3.connect("toko_it.db")
    cursor = conn.cursor()
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS transaksi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT,
        total_bayar INTEGER
    )
    """)
    waktu_sekarang = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    cursor.execute("INSERT INTO transaksi (tanggal, total_bayar) VALUES (?, ?)", (waktu_sekarang, total))
    conn.commit()
    conn.close()

@app.route("/")
def halaman_login():
    return render_template("login.html")

@app.route("/proses-login", methods=["POST"])
def proses_login():
    user_input = request.form.get("username")
    pass_input = request.form.get("password")
    if user_input == "admin" and pass_input == "rahasia":
        return redirect("/kasir")
    else:
        return "<h3>Login Gagal! Username atau password salah.</h3> <a href='/'>Kembali</a>"

@app.route("/kasir")
def halaman_kasir():
    return render_template("kasir.html")

# PINTU RUTE UTAMA UNTUK MENERIMA DAN MENYIMPAN DATA DARI WEB
@app.route("/simpan-transaksi", methods=["POST"])
def simpan_transaksi():
    total_input = request.form.get("total_bayar")
    if total_input:
        simpan_ke_db(int(total_input))
        return "<h3>✓ Transaksi Berhasil Disimpan ke Database SQL!</h3> <a href='/kasir'>Input Transaksi Baru</a>"
    return "Gagal menyimpan data."

if __name__ == "__main__":
    app.run(debug=True, port=5000)
