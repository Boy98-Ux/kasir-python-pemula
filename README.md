# 🛒 Aplikasi Kasir Digital Minimarket

Aplikasi kasir pintar berbasis web yang dirancang khusus untuk membantu mengelola transaksi toko secara digital, aman, dan permanen. Proyek ini dibuat sebagai portofolio pengembang.

### 🛠️ Teknologi yang Digunakan
* **Backend:** Python 3 & Flask Framework
* **Frontend:** HTML5, CSS3, JavaScript
* **Database:** MySQL (MariaDB)

---

### 💻 Cara Menjalankan Proyek Di Lokal

1. **Clone Repositori**
```bash
git clone https://github.com
cd kasir-python-pemula
```

2. **Install Dependensi**
   Pastikan Flask dan MySQL Connector sudah terinstal di komputer Anda:
```bash
pip install flask mysql-connector-python
```

3. **Setup Database MySQL**
   Masuk ke database MySQL/MariaDB Anda, lalu buat database dan tabel dengan perintah SQL berikut:
```sql
CREATE DATABASE toko_it;
USE toko_it;

CREATE TABLE barang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_barang VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    stok INT NOT NULL
);

INSERT INTO barang (nama_barang, harga, stok) VALUES 
('Mouse Logitech G Pro', 1200000, 10),
('Keyboard Mechanical Rexus', 450000, 15),
('Monitor ASUS 24 Inch', 1800000, 5);
```

4. **Jalankan Server Aplikasi**
```bash
python3 server.py
```
