import 'dart:io';
import 'barang.dart';
import 'user.dart';
import 'undo_stack.dart';
import 'notifikasi_queue.dart';
import 'search_tree.dart';

void main() {
  var user = User("Dani");
  var stack = UndoStack();
  var queue = NotificationQueue();
  var tree = SearchTree();
  List<Barang> semuaBaraang = [];

  void menuPengguna() {
    while (true) {
      print('\n--- Menu Pengguna ---');
      print('1. Laporkan barang hilang');
      print('2. Cari barang');
      print('3. Tampilkan Semua Barang');
      print('4. lihat notifikasi');
      print('5. undo laporan');
      print('0. keluar');
      stdout.write('masukkan: ');
      var choice2 = stdin.readLineSync();

      switch (choice2) {
        case '1':
          stdout.write("\nNama Barang: ");
          var nama = stdin.readLineSync()!;
          stdout.write('Deksripsi: ');
          var desc = stdin.readLineSync()!;
          stdout.write("Lokasi: ");
          var lokasi = stdin.readLineSync()!;
          stdout.write("Pemilik: ");
          var pemilik = stdin.readLineSync()!;
          stdout.write("kontak/nomor telepon: ");
          var kontak = stdin.readLineSync();

          var barang = Barang(
              nama, desc, lokasi, DateTime.now(), "hilang", pemilik, kontak);

          // user.tambahLaporan(barang);
          semuaBaraang.add(barang);
          tree.insert(barang);
          stack.push(barang);

          for (var b in semuaBaraang) {
            if (b.nama.toLowerCase() == nama.toLowerCase() &&
                b.status == "ditemukan") {
              queue.enqueue(
                  "Barang '${b.nama}' mungkin telah ditemukan di $lokasi sekarang berada di admin");
            }
          }
          print("laporan berhasil ditambahkan");
          break;

        case '2':
          stdout.write("Masukkan nama barang yang dicari: ");
          var keyword = stdin.readLineSync()!;
          var result = tree.search(keyword);
          if (result != null) {
            print("\n--- Hasil Pencarian ---");
            result.tampilkan();
          } else {
            print("Barang tidak ditemukan.");
          }
          break;

        case '3':
          if (semuaBaraang.isEmpty) {
            print("Belum ada data barang.");
          } else {
            print("\n--- Daftar Semua Barang ---");
            print('Daftar Barang Hilang dilaporkan: ');
            for (var b in semuaBaraang.where((b) => b.status == 'hilang')) {
              print(
                  "Nama: ${b.nama} | Lokasi: ${b.lokasi} | Status: ${b.status} | Tanggal: ${b.tanggal} | Pemilik: ${b.pemilik} | No Hp: ${b.kontak ?? 'tidak tersedia'}");
            }
          }
          print('\nlaporan barang ditemukan berada di admin: ');
          for (var b in semuaBaraang.where((b) => b.status == 'ditemukan')) {
            print(
                "Nama: ${b.nama} | Lokasi: ${b.lokasi} | Status: ${b.status} | Tanggal: ${b.tanggal} | Pemilik: ${b.pemilik}");
          }
          break;

        case '4':
          if (queue.isEmpty()) {
            print("Tidak ada notifikasi.");
          } else {
            print("Notifikasi:");
            while (!queue.isEmpty()) {
              print("- ${queue.dequeue()}");
            }
          }
          break;

        case '5':
          var undoBarang = stack.undo();
          if (undoBarang != null) {
            user.laporan.remove(undoBarang);
            semuaBaraang.remove(undoBarang);
            tree.delete(undoBarang.nama);
            print("Laporan barang '${undoBarang.nama}' telah di-undo.");
          } else {
            print("Tidak ada laporan untuk di-undo.");
          }
          break;

        case '0':
          print('Terimakasih telah menggunakan program');
          return;
        default:
          print('masukkan pilihan yang tepat!');
      }
    }
  }

  void menuAdmin() {
    while (true) {
      print('\n--- Menu Admin ---');
      print('1. tambahkan barang ditemukan');
      print('2. cari barang');
      print('3. tampilkan semua barang');
      print('4. lihat notifikasi');
      print('5. undo barang ditemukan');
      print('0. keluar');
      stdout.write("Pilih (1/2/3/4/0): ");
      var choice3 = stdin.readLineSync();

      switch (choice3) {
        case '1':
          stdout.write("Nama barang ditemukan: ");
          var nama = stdin.readLineSync()!;
          stdout.write("Deskripsi: ");
          var desc = stdin.readLineSync()!;
          stdout.write("Lokasi: ");
          var lokasi = stdin.readLineSync()!;
          stdout.write("pemilik: ");
          var pemilik = stdin.readLineSync();

          var barang =
              Barang(nama, desc, lokasi, DateTime.now(), "ditemukan", pemilik);

          semuaBaraang.add(barang);
          tree.insert(barang);
          stack.push(barang);

          // Cek apakah ada yang melaporkan barang yang sama
          for (var b in semuaBaraang) {
            if (b.nama.toLowerCase() == nama.toLowerCase() &&
                b.status == "hilang") {
              queue.enqueue(
                  "Barang '${b.nama}' $lokasi mungkin ada di laporan kehilangan ");
            }
          }

          print("Barang $nama berhasil ditambahkan ke barang temuan");
          break;

        case '2':
          stdout.write("Masukkan nama barang yang dicari: ");
          var keyword = stdin.readLineSync()!;
          var result = tree.search(keyword);
          if (result != null) {
            print("Barang ditemukan:");
            result.tampilkan();
          } else {
            print("Barang tidak ditemukan.");
          }
          break;

        case '3':
          if (semuaBaraang.isEmpty) {
            print("Belum ada data barang.");
          } else {
            print("\n--- Daftar Semua Barang ---");
            print("barang ditemukan berada diadmin: ");
            for (var b in semuaBaraang.where((b) => b.status == 'ditemukan')) {
              print(
                  "Nama: ${b.nama} | Lokasi: ${b.lokasi} | Status: ${b.status} | Tanggal: ${b.tanggal} | Pemilik: ${b.pemilik}");
              ;
            }
          }
          print('\ndaftar barang hilang dilaporkan: ');
          for (var b in semuaBaraang.where((b) => b.status == 'hilang')) {
            print(
                "Nama: ${b.nama} | Lokasi: ${b.lokasi} | Status: ${b.status} | Tanggal: ${b.tanggal} | Pemilik: ${b.pemilik} | No Hp: ${b.kontak ?? 'tidak tersedia'}");
          }
          break;

        case '4':
          if (queue.isEmpty()) {
            print("Tidak ada notifikasi.");
          } else {
            print("Notifikasi:");
            while (!queue.isEmpty()) {
              print("- ${queue.dequeue()}");
            }
          }
          break;

        case '5':
          var undoBarang = stack.undo();
          if (undoBarang != null) {
            semuaBaraang.remove(undoBarang);
            tree.delete(undoBarang.nama);
            print("Laporan barang '${undoBarang.nama}' telah di-undo.");
          } else {
            print("Tidak ada laporan untuk di-undo.");
          }
          break;

        case '0':
          print("Terima kasih telah menggunakan aplikasi.");
          return;

        default:
          print("Menu tidak valid.");
      }
    }
  }

  while (true) {
    print('\nsistem informasi kehilangan');
    print('1. mahasiswa/pengguna');
    print('2. admin');
    print('3. keluar');
    stdout.write('pilih (1/2/3): ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        menuPengguna();
        break;
      case '2':
        stdout.write("masukkan password admin: ");
        String? pass = stdin.readLineSync()!;
        if (pass == '230506') {
          menuAdmin();
        } else {
          print('password salah!');
        }
        break;
      case '3':
        print('Terimakasih telah menggunakan program');
        return;
      default:
        print('pilihan tidak valid. silahkan coba lagi');
    }
  }
}
