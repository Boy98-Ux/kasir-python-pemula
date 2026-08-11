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
