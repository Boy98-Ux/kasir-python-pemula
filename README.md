# 🛒 Aplikasi Kasir Digital Minimarket (Toko IT)

Aplikasi manajemen kasir berbasis web sederhana yang dibangun menggunakan **Flask (Python)** dan **SQLite3**. Aplikasi ini mendukung fitur pengelolaan stok, kalkulasi diskon otomatis secara realtime di sisi klien, sistem keranjang belanja multi-item (*session-based*), serta pencetakan nota/resi pembayaran yang dapat langsung disimpan ke format PDF.

## 📁 Struktur Dokumen Proyek
```text
kasir-python-pemula/
│
├── server.py
├── requirements.txt
├── .gitignore
├── LICENSE
└── templates/
    ├── login.html
    ├── kasir.html
    └── nota.html
```

## 🔐 1. Fitur Utama & Keamanan
* **Sistem Autentikasi**: Membatasi akses menu utama dengan data uji coba berikut:
  * **Username**: `admin`
  * **Password**: `rahasia`
* **Inisialisasi Database Otomatis**: Membuat file database `toko_it.db` serta tabel `produk` dan `transaksi` secara otomatis jika belum ada saat aplikasi dinyalakan.
* **Kalkulator Diskon Realtime**: Form persentase diskon terintegrasi JavaScript (`oninput`) untuk memotong nilai total tagihan di layar kasir secara langsung tanpa muat ulang halaman.
* **Cetak Nota & Simpan PDF**: Tombol *Bayar & Cetak Struk* akan mengunci data transaksi, mengurangi kuantitas stok di database, dan mengarahkan pengguna ke halaman `/nota` yang memicu jendela cetak browser (`window.print()`).

## ⚙️ 2. Cara Instalasi & Menjalankan Aplikasi

### Langkah 1: Kloning Repositori
```bash
git clone https://github.com
cd kasir-python-pemula
```

### Langkah 2: Install Dependensi
```bash
pip install -r requirements.txt
```

### Langkah 3: Jalankan Aplikasi
```bash
python3 server.py
```
Buka browser Anda dan akses tautan lokal: `http://127.0.0`
