import sqlite3
from datetime import datetime

# 1. KONEKSI KE DATABASE (Jika file belum ada, otomatis dibuatkan)
conn = sqlite3.connect("toko_it.db")
cursor = conn.cursor()

# 2. MEMBUAT TABEL TRANSAKSI (Jika belum ada)
cursor.execute("""
CREATE TABLE IF NOT EXISTS transaksi (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tanggal TEXT,
    total_bayar INTEGER
)
""")
conn.commit()

print("=== APLIKASI KASIR DIGITAL + DATABASE ===")

total_belanja = 0
nomor_barang = 1

# 3. PROSES INPUT BARANG (LOOPING)
while True:
    print(f"\n--- Barang ke-{nomor_barang} ---")
    harga = int(input("Harga Barang (Ketik 0 jika selesai): Rp "))
    if harga == 0:
        break
    jumlah = int(input("Jumlah Barang: "))
    total_belanja += (harga * jumlah)
    nomor_barang += 1

# 4. HITUNG DISKON
if total_belanja > 100000:
    diskon = total_belanja * 0.1
    total_belanja -= diskon
    print(f"\nSelamat! Dapat diskon 10% sebesar: Rp {int(diskon)}")

total_akhir = int(total_belanja)
print(f"Total yang harus dibayar: Rp {total_akhir}")

# 5. SIMPAN TOTAL AKHIR KE DATABASE SQL
waktu_sekarang = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
cursor.execute("INSERT INTO transaksi (tanggal, total_bayar) VALUES (?, ?)", (waktu_sekarang, total_akhir))
conn.commit()
print("✓ Data transaksi berhasil disimpan permanen ke Database SQL!")

# 6. TAMPILKAN RIWAYAT NOTA DARI DATABASE
print("\n=== RIWAYAT NOTA PENJUALAN DI DATABASE ===")
cursor.execute("SELECT * FROM transaksi")
semua_data = cursor.fetchall()

for baris in semua_data:
    print(f"ID: {baris[0]} | Waktu: {baris[1]} | Total Bayar: Rp {baris[2]}")

# Tutup koneksi database
conn.close()
print("==========================================")
