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
