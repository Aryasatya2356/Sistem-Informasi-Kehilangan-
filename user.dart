import 'barang.dart';

class User {
  String nama;
  List<Barang> laporan = [];

  User(this.nama);

  void tambahLaporan(Barang barang) {
    laporan.add(barang);
  }
}
