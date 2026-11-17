import 'package:flutter/material.dart';

/// Status mahasiswa (enum).
enum StatusMahasiswa { aktif, cuti, lulus }

extension StatusMahasiswaX on StatusMahasiswa {
  String get label {
    switch (this) {
      case StatusMahasiswa.aktif:
        return 'Mahasiswa Aktif';
      case StatusMahasiswa.cuti:
        return 'Cuti';
      case StatusMahasiswa.lulus:
        return 'Lulus';
    }
  }

  Color get warna {
    switch (this) {
      case StatusMahasiswa.aktif:
        return const Color(0xFF2E9E6B);
      case StatusMahasiswa.cuti:
        return const Color(0xFFE09A2B);
      case StatusMahasiswa.lulus:
        return const Color(0xFF3B82C4);
    }
  }
}

/// Satu baris data kontak yang akan ditampilkan di InfoCard.
class InfoEntry {
  final IconData icon;
  final String label;
  final String value;

  const InfoEntry({
    required this.icon,
    required this.label,
    required this.value,
  });
}

/// Model data diri mahasiswa.
class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final String foto;
  final List<String> hobi;
  final List<String> skill;
  final StatusMahasiswa status;

  const Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.foto,
    required this.hobi,
    required this.skill,
    this.status = StatusMahasiswa.aktif,
  });

  /// Nama depan, mis. "MUZAKKI".
  String get namaDepan => nama.split(' ').first;

  /// Daftar kontak; email yang kosong tidak ditampilkan.
  List<InfoEntry> get daftarKontak {
    final list = <InfoEntry>[
      InfoEntry(icon: Icons.badge_outlined, label: 'NIM', value: nim),
      InfoEntry(icon: Icons.school_outlined, label: 'Jurusan', value: jurusan),
      InfoEntry(icon: Icons.phone_outlined, label: 'Telepon', value: telepon),
    ];
    if (email.trim().isNotEmpty) {
      list.add(
        InfoEntry(icon: Icons.mail_outline, label: 'Email', value: email),
      );
    }
    return list;
  }

  /// Membuat salinan Profile dengan sebagian data diubah.
  Profile copyWith({StatusMahasiswa? status, List<String>? hobi, List<String>? skill}) {
    return Profile(
      nama: nama,
      nim: nim,
      jurusan: jurusan,
      email: email,
      telepon: telepon,
      foto: foto,
      hobi: hobi ?? this.hobi,
      skill: skill ?? this.skill,
      status: status ?? this.status,
    );
  }

  /// Pindah ke status berikutnya (aktif -> cuti -> lulus -> aktif).
  Profile statusBerikutnya() {
    const values = StatusMahasiswa.values;
    final next = values[(status.index + 1) % values.length];
    return copyWith(status: next);
  }

  /// Ringkasan singkat satu kalimat.
  String ringkasan() =>
      '$namaDepan - $jurusan, ${hobi.length} hobi, ${skill.length} skill';
}
