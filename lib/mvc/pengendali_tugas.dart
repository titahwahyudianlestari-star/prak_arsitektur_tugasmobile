import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class PengendaliTugas {
  PengendaliTugas(this._repo);

  final RepositoriTugas _repo;
  String? _galat;
  bool _filterBelumSelesai = false;

  List<Tugas> get daftar => _repo.daftar;

  List<Tugas> get daftarTerlihat => _filterBelumSelesai
      ? daftar.where((tugas) => !tugas.selesai).toList()
      : daftar;

  int get totalTugas => daftar.length;

  bool get filterBelumSelesai => _filterBelumSelesai;

  String? get galat => _galat;

  int get jumlahSelesai =>
      daftar.where((tugas) => tugas.selesai).length;

  bool tambah(String input) {
    _galat = validasiJudul(input);
    if (_galat != null) return false;

    _repo.tambah(input.trim());
    return true;
  }

  void ubahStatus(int id) => _repo.ubahStatus(id);

  void ubahFilter(bool aktif) {
    _filterBelumSelesai = aktif;
  }
}