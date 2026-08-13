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

python3 kasir_sql.py
git config --global user.name "Boy98-Ux"
sudo apt update
sudo apt install git -y
git --version
git config --global user.name "Boy98-Ux"
git config --global user.email "boymalau46@gmail.com"
git config --global init.defaultBranch main
git init
git add .
git commit -m "Proyek Kasir Python Pertama Saya"
git remote add origin https://github.com
git push -u origin main
git remote remove origin
git remote add origin https://github.com/Boy98-Ux/kasir-python-pemula.git
git push -u origin main
git rm -r --cached .config .local .bash_history .bash_logout .bashrc .Xauthority .sommelierrc .profile .gitconfig
git commit -m "Merapikan repositori dan menyisakan file program utama"
git push origin main
git rm -r --cached "python3 kasir.py" "python3 kasir.py.save" _sudo_as_admin_successful kasir kasir.py.save kasir.py.save.1 tes.py
git commit -m "Membersihkan file sampah dan menyisakan program utama"
git push origin main
cat << 'EOF' > login.html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Kasir Toko IT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .kotak-login {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            width: 300px;
            text-align: center;
        }
        h2 { color: #333; margin-bottom: 20px; }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #2b6cb0;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        button:hover { background-color: #2c5282; }
    </style>
</head>
<body>

    <div class="kotak-login">
        <h2>🔒 Login Admin Toko</h2>
        <input type="text" placeholder="Masukkan Username">
        <input type="password" placeholder="Masukkan Password">
        <button onclick="alert('Halo Admin! Sistem tampilan web sedang disiapkan.')">Masuk Sistem</button>
    </div>

</body>
</html>
EOF

cat << 'EOF' > kasir.html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Kasir - Toko IT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin: 0 auto;
        }
        h2 { color: #2b6cb0; border-bottom: 2px solid #2b6cb0; padding-bottom: 10px; }
        .input-group {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
            background-color: #2b6cb0;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover { background-color: #2c5282; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th { background-color: #f2f2f2; }
        .total-box {
            margin-top: 20px;
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            color: #e53e3e;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>🛒 Transaksi Kasir Toko IT</h2>
        
        <div class="input-group">
            <input type="text" placeholder="Nama Barang">
            <input type="number" placeholder="Harga (Rp)">
            <input type="number" placeholder="Jumlah">
            <button onclick="alert('Barang berhasil ditambahkan ke daftar visual!')">Tambah</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Barang</th>
                    <th>Harga</th>
                    <th>Qty</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Mouse Logotech</td>
                    <td>Rp 50.000</td>
                    <td>2</td>
                    <td>Rp 100.000</td>
                </tr>
            </tbody>
        </table>

        <div class="total-box">
            Total Bayar: Rp 100.000
        </div>
    </div>

</body>
</html>
EOF

git add .
git commit -m "Menambahkan portofolio tampilan web Front kasir"
git push origin main
git pull origin main --rebase
git push origin main
pip3 install flask
sudo apt install python3-pip -y
pip3 install flask
sudo apt install python3-venv -y
python3 -m venv vwen
source vwen/bin/activate
pip3 install flask
mkdir templates
mv login.html kasir.html templates/
cat << 'EOF' > server.py
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/")
def halaman_login():
    return render_template("login.html")

@app.route("/proses-login", methods=["POST"])
def proses_login():
    user_input = request.form.get("username")
    pass_input = request.form.get("password")
    
    if user_input == "admin" and pass_input == "rahasia":
        return f"<h3>Login Sukses! Selamat bekerja, {user_input}.</h3> <a href='/kasir'>Masuk ke Menu Kasir</a>"
    else:
        return "<h3>Login Gagal! Username atau password salah.</h3> <a href='/'>Kembali ke Login</a>"

@app.route("/kasir")
def halaman_kasir():
    return render_template("kasir.html")

if __name__ == "__main__":
    app.run(debug=True, port=5000)
EOF

cat << 'EOF' > templates/login.html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Kasir Toko IT</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .kotak-login { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 300px; text-align: center; }
        h2 { color: #333; margin-bottom: 20px; }
        input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background-color: #2b6cb0; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; }
        button:hover { background-color: #2c5282; }
    </style>
</head>
<body>

    <div class="kotak-login">
        <h2>🔒 Login Admin Toko</h2>
        <form action="/proses-login" method="POST">
            <input type="text" name="username" placeholder="Masukkan Username" required>
            <input type="password" name="password" placeholder="Masukkan Password" required>
            <button type="submit">Masuk Sistem</button>
        </form>
    </div>

</body>
</html>
EOF

python3 server.py
git add .
git commit -m "Mengintegrasikan Front End HTML dengan Backend Python Flask"
git push origin main
git rm -r --cached .cache/
git commit -m "Membersihkan folder cache sistem dan menyisakan file utama"
git push origin main
python3 server.py
cat << 'EOF' > templates/kasir.html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Kasir - Toko IT</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 20px; }
        .container { max-width: 600px; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin: 0 auto; }
        h2 { color: #2b6cb0; border-bottom: 2px solid #2b6cb0; padding-bottom: 10px; }
        .input-group { display: flex; gap: 10px; margin-bottom: 15px; }
        input { flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { padding: 10px 20px; background-color: #2b6cb0; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        button:hover { background-color: #2c5282; }
    </style>
</head>
<body>

    <div class="container">
        <h2>🛒 Transaksi Kasir Toko IT (Terhubung ke SQL)</h2>
        
        <!-- Form untuk mengirim data input belanjaan ke Python -->
        <form action="/simpan-transaksi" method="POST" class="input-group">
            <input type="number" name="total_bayar" placeholder="Masukkan Total Belanja (Rp)" required>
            <button type="submit">Simpan ke SQL</button>
        </form>
        
        <br>
        <a href="/">← Keluar / Log Out</a>
    </div>

</body>
</html>
EOF

python3 server.py
cat << 'EOF' > server.py
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
EOF

python3 server.py
touch .gitignore
nano .gitignore
git rm --cached toko_it.db
nano README.md
git add .
git commit -m "docs: add gitignore and improve readme aesthetics"
git push origin main
git pull origin main --rebase
git push origin main
nano .gitignore
git rm -r --cached .cache
git add .gitignore
git commit -m "chore: ignore and remove pip cache directory"
git push origin main
git config --global user.email email_"github_boymalau46@gmail.com"
git config --global user .name "Boy98-Ux"
git config --global user.email "email_github_boymalau46@gmail.com"
git config --global user.name "Boy98-Ux"
git rm -r --cached .cache
git add .gitignore
git commit -m "chore: ignore and remove pip cache directory"
git push origin main
mkdir arsip_latihan
git mv aplikasi.py kasir.py kasir_loop.py kasir_sql.py arsip_latihan/
git commit -m "refactor:move old practice files into archive folder"
git push origin main
git mv login.py arsip_latihan/
git commit -m "refactor:move login.py to archive folder"
git push origin main
sudo apt update && sudo apt install -y python3-pip python3-venv
pip install flask mysql-connector-python
cd ~/templates
nano app.py
python3 app.py
nano app.py
python3 app.py
sudo service mysql start
sudo apt update && sudo apt istall -y mariadb-server
sudo apt update && sudo apt install -y mariadb-server
sudo service mariadb start
sudo mysql -u root
python3 app.py
sudo mysql -u root
python3 app.py
python3 appp.py
python3 app.py
cd ~/templates
python3 -m http.server 5000
pip freeze > requirements.txt
is
ls
git add requirements.txt
git commit -m "add requirements.txt"
git push origin main
git push origin main
git pull origin main --allow-unrelated-histories
git push origin main
git config pull.rebase false
git pull origin main --allow-unrelated-histories
git push origin main
touch LICENSE
nano LICENSE
git add LICENSE
git commit -m "add LICENSE file"
git push origin main
cd ~/kasir-python-pemula
ls
python server.py
python3 server.py
pip3 install -r requirements.txt
source vwen/bin/activate
pip3 install -r requirements.txt
python3 server.py
sqlite3 database.db
sqlite database.db
sudo apt update && sudo apt install sqlite3 -y
sqlite3 database.db
python3 server.py
grep -n "sqlite3.connect" server.py
nano +9 server.py
grep -n "/kasir".py
nano server.py
python3 server.py
source vwen/bin/activate
python3 server.py
nano buat_table.py
python3 buat_table.py
python3 server.py
nano server.py
nano templates/kasir.html
python3 server.py
nano templates/login.html
