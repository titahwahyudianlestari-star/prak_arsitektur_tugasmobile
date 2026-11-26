import 'package:flutter/foundation.dart';

import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class TugasViewModel extends ChangeNotifier {
  TugasViewModel(this._repo);

  final RepositoriTugas _repo;
  String? _galat;
  bool _filterBelumSelesai = false;

  // Mengambil seluruh daftar tugas.
  List<Tugas> get daftar => _repo.daftar;

  // Mengambil daftar tugas sesuai filter.
  List<Tugas> get daftarTerlihat => _filterBelumSelesai
      ? daftar.where((tugas) => !tugas.selesai).toList()
      : daftar;

  // Menghitung seluruh tugas.
  int get totalTugas => daftar.length;

  // Mengetahui status filter.
  bool get filterBelumSelesai => _filterBelumSelesai;

  // Mengambil pesan kesalahan.
  String? get galat => _galat;

  // Menghitung jumlah tugas selesai.
  int get jumlahSelesai =>
      daftar.where((tugas) => tugas.selesai).length;

  // Menambahkan tugas baru.
  bool tambah(String input) {
    _galat = validasiJudul(input);
    final berhasil = _galat == null;

    if (berhasil) {
      _repo.tambah(input.trim());
    }

    notifyListeners();
    return berhasil;
  }

  // Mengubah status tugas.
  void ubahStatus(int id) {
    _repo.ubahStatus(id);
    notifyListeners();
  }

  // Mengubah status filter.
  void ubahFilter(bool aktif) {
    _filterBelumSelesai = aktif;
    notifyListeners();
  }
}