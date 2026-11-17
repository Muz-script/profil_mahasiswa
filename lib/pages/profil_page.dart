import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/profile.dart';
import '../widgets/hobby_item.dart';
import '../widgets/info_card.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_item.dart';

class ProfilPage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ProfilPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Profile _profile = const Profile(
    nama: 'MUZAKKI FADLILLAH GUNADI',
    nim: '24552011062',
    jurusan: 'Teknik Informatika',
    email: '', // isi jika ingin menampilkan email
    telepon: '081122223333',
    foto: 'assets/images/profile.jpg',
    hobi: ['Bersepeda', 'Touring'],
    skill: ['Soft Spoken'],
    status: StatusMahasiswa.aktif,
  );

  void _ubahStatus() {
    setState(() => _profile = _profile.statusBerikutnya());
  }

  Future<void> _salin(String label, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$label disalin'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                  child: _buildBody(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 290,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(36)),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profil Mahasiswa',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    IconButton(
                      tooltip: widget.isDark ? 'Mode terang' : 'Mode gelap',
                      onPressed: widget.onToggleTheme,
                      icon: Icon(
                        widget.isDark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(60),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(_profile.foto),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final kontak = _profile.daftarKontak;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                _profile.nama,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_profile.jurusan}  •  ${_profile.nim}',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              ActionChip(
                onPressed: _ubahStatus,
                avatar: Icon(Icons.circle, size: 12, color: _profile.status.warna),
                label: Text(_profile.status.label),
                tooltip: 'Ketuk untuk mengubah status',
              ),
            ],
          ),
        ),

        // ----- Kontak & info: ListView.builder -----
        const SectionTitle(title: 'Data Diri & Kontak', icon: Icons.person_rounded),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kontak.length,
          itemBuilder: (context, i) {
            final item = kontak[i];
            return InfoCard(
              icon: item.icon,
              label: item.label,
              value: item.value,
              onTap: () => _salin(item.label, item.value),
            );
          },
        ),

        // ----- Hobi: GridView.builder -----
        const SectionTitle(title: 'Hobi', icon: Icons.pedal_bike_rounded),
        LayoutBuilder(
          builder: (context, constraints) {
            final kolom = constraints.maxWidth >= 480 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _profile.hobi.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kolom,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, i) => HobbyItem(nama: _profile.hobi[i]),
            );
          },
        ),

        // ----- Skill: ListView.builder -----
        const SectionTitle(title: 'Skill', icon: Icons.bolt_rounded),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _profile.skill.length,
          itemBuilder: (context, i) => SkillItem(nama: _profile.skill[i]),
        ),

        const SizedBox(height: 16),
        Center(
          child: Text(
            _profile.ringkasan(),
            textAlign: TextAlign.center,
            style: textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
