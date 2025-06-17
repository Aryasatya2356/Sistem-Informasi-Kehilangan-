class Barang {
  String nama;
  String deskripsi;
  String lokasi;
  DateTime tanggal;
  String status; // 'hilang' atau 'ditemukan'
  String? pemilik;
  String? kontak;

  Barang(this.nama, this.deskripsi, this.lokasi, this.tanggal, this.status,
      this.pemilik,
      [this.kontak]);

  void tampilkan() {
    print("Nama: $nama");
    print("Deskripsi: $deskripsi");
    print("Lokasi: $lokasi");
    print("Tanggal: $tanggal");
    print("Status: $status");
    print("Pemilik: $pemilik");
    if (kontak != null) print("No. Hp: $kontak");
  }
}
