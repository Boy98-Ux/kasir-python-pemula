python3 --version
nano kasir .py
python3 --version
nano kasir.py
python3 kasir.py
nano kasir .py
python3 kasir .py
nano kasir.py
python3 kasir.py
python3--version
python3 -- version
python3 --version
nano kasir.py
rm kasir.py
clear
python3 tes.py

echo 'print("Halo, Python berhasil jalan")' > tes.py
python3 tes.py
nano kasir.py
python3 kasir.py
nano login.py
python3 login.py
nano aplikasi.py
python3 aplikasi.py
nano aplikasi.py
python3 aplikasi.py
rm aplikasi.py
cat << 'EOF' > aplikasi.py
print("=== SISTEM KEAMANAN KASIR ===")
username = input("Username: ")
password = input("Password: ")

if username == "admin" and password == "rahasia":
    print("\nLogin Sukses!\n")
    print("=== MULAI TRANSAKSI TOKO IT ===")
    harga = int(input("Harga Barang: Rp "))
    jumlah = int(input("Jumlah Barang: "))
    total = harga * jumlah
    print(f"Total awal: Rp {total}")

    if total > 100000:
        print("Dapat diskon 10%!")
        total = total * 0.9

    print(f"Total bayar: Rp {int(total)}")
    print("===============================")
else:
    print("Akses Ditolak! Anda bukan admin toko.")
EOF

python3 aplikasi.py
cat << 'EOF' > kasir_loop.py
print("=== APLIKASI KASIR BANYAK BARANG ===")

total_belanja = 0
nomor_barang = 1

while True:
    print(f"\n--- Barang ke-{nomor_barang} ---")
    harga = int(input("Harga Barang (Ketik 0 jika sudah selesai): Rp "))
    
    # JIKA KASIR KETIK 0, PERULANGAN BERHENTI
    if harga == 0:
        break
        
    jumlah = int(input("Jumlah Barang: "))
    
    # Hitung subtotal barang ini lalu tambahkan ke total keseluruhan
    subtotal = harga * jumlah
    total_belanja = total_belanja + subtotal
    
    nomor_barang = nomor_barang + 1

# KELUAR DARI LOOPING, HITUNG DISKON DAN TOTAL AKHIR
print("\n===============================")
print(f"Total Awal Belanja: Rp {total_belanja}")

if total_belanja > 100000:
    diskon = total_belanja * 0.1
    total_belanja = total_belanja - diskon
    print(f"Selamat! Dapat diskon 10% sebesar: Rp {int(diskon)}")

print(f"Total yang harus dibayar: Rp {int(total_belanja)}")
print("=== Terima Kasih ===")
EOF

python3 kasir_loop.py
cat << 'EOF' > kasir_sql.py
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
EOF

