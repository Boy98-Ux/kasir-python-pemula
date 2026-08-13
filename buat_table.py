import sqlite3

conn = sqlite3.connect("toko_it.db")
cursor = conn.cursor()

# 1. Membuat tabel produk jika belum ada
cursor.execute("""
CREATE TABLE IF NOT EXISTS produk (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama_produk TEXT NOT NULL,
    harga INTEGER NOT NULL,
    stok INTEGER NOT NULL
)
""")

# 2. Memasukkan data contoh (opsional, jika tabel masih kosong)
cursor.execute("SELECT COUNT(*) FROM produk")
if cursor.fetchone()[0] == 0:
    data_contoh = [
        ("Mouse Logi", 50000, 10),
        ("Keyboard RGB", 120000, 5),
        ("Kabel HDMI", 25000, 20)
    ]
    cursor.executemany("INSERT INTO produk (nama_produk, harga, stok) VALUES (?, ?, ?)", data_contoh)
    print("Data contoh produk berhasil ditambahkan!")

conn.commit()
conn.close()
print("Tabel produk berhasil dibuat!")
