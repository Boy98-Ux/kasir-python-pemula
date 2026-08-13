from flask import Flask, request, render_template, jsonify
import mysql.connector

app = Flask(__name__, template_folder='.')

# Fungsi pembantu untuk koneksi ke MySQL Database Toko IT Anda
def ambil_koneksi_db():
    return mysql.connector.connect(
        host="localhost",
        user="root", 
        password="",
        database="toko_it"
    )

@app.route('/')
def index():
    # 1. Ambil daftar barang dari database untuk dimasukkan ke dropdown HTML otomatis
    db = ambil_koneksi_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT id, nama_barang, harga, stok FROM barang")
    daftar_barang = cursor.fetchall()
    cursor.close()
    db.close()
    
    # Kirim data barang ke halaman kasir.html
    return render_template('kasir.html', barang=daftar_barang)

@app.route('/simpan-transaksi', methods=['POST'])
def simpan_transaksi():
    # Menerima data daftar belanjaan dalam bentuk JSON dari JavaScript
    data = request.get_json()
    keranjang = data.get('keranjang', [])
    
    db = ambil_koneksi_db()
    cursor = db.cursor()
    
    try:
        # Loop semua barang yang dibeli di dalam keranjang belanja
        for item in keranjang:
            barang_id = item['id']
            jumlah_beli = int(item['jumlah'])
            
            # --- VALIDASI STOK DI SISI SERVER ---
            cursor.execute("SELECT stok, nama_barang FROM barang WHERE id = %s", (barang_id,))
            hasil = cursor.fetchone()
            stok_sekarang = hasil[0]
            nama_barang = hasil[1]
            
            if stok_sekarang < jumlah_beli:
                return jsonify({"status": "error", "message": f"Stok untuk {nama_barang} tidak cukup! Sisa stok: {stok_sekarang}"}), 400
                
            # --- PENGURANGAN STOK DI DATABASE ---
            query = "UPDATE barang SET stok = stok - %s WHERE id = %s"
            cursor.execute(query, (jumlah_beli, barang_id))
            
        db.commit() # Simpan perubahan jika semua item lolos validasi stok
        return jsonify({"status": "success", "message": "Transaksi Sukses! Stok telah dikurangi."})
        
    except Exception as e:
        db.rollback() # Batalkan jika ada error sistem
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

if __name__ == '__main__':
    app.run(debug=True, port=5000)

