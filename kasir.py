print("===TOKO IT ===")
harga = int(input("Harga: "))
jumlah = int(input("Jumlah: "))
total = harga * jumlah
print (f"Total awal: Rp {total}")



if total > 100000:
	print("Dapat dison 10%!")
	total = total * 0.9


print(f"Total bayar: Rp {int(total)}")
