
import 'package:flutter/material.dart';

class RiwayatKonselingGuruPage extends StatefulWidget {
  final List<Map<String, String>> daftarPengajuan;

  const RiwayatKonselingGuruPage({
    super.key,
    required this.daftarPengajuan,
  });

  @override
  State<RiwayatKonselingGuruPage> createState() =>
      _RiwayatKonselingGuruPageState();
}

class _RiwayatKonselingGuruPageState
    extends State<RiwayatKonselingGuruPage> {
  static const Color warnaUtama = Color(0xFF3978C5);
  static const Color warnaLatar = Color(0xFFF4F7FC);

  String filterStatus = 'Semua';
  String kataKunci = '';

  List<Map<String, String>> get semuaRiwayat {
    return widget.daftarPengajuan.where((pengajuan) {
      final status = pengajuan['status'] ?? '';

      return status == 'Diterima' || status == 'Ditolak';
    }).toList().reversed.toList();
  }

  List<Map<String, String>> get riwayatKonseling {
    return semuaRiwayat.where((pengajuan) {
      final status = pengajuan['status'] ?? '';
      final nama = (pengajuan['nama'] ?? '').toLowerCase();
      final kelas = (pengajuan['kelas'] ?? '').toLowerCase();
      final alasan = (pengajuan['alasan'] ?? '').toLowerCase();
      final keyword = kataKunci.toLowerCase();

      final cocokStatus =
          filterStatus == 'Semua' || status == filterStatus;

      final cocokPencarian = nama.contains(keyword) ||
          kelas.contains(keyword) ||
          alasan.contains(keyword);

      return cocokStatus && cocokPencarian;
    }).toList();
  }

  int get jumlahDiterima => semuaRiwayat
      .where((pengajuan) => pengajuan['status'] == 'Diterima')
      .length;

  int get jumlahDitolak => semuaRiwayat
      .where((pengajuan) => pengajuan['status'] == 'Ditolak')
      .length;

  @override
  Widget build(BuildContext context) {
    final riwayat = riwayatKonseling;

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat Konseling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Column(
              children: [
                _buildSearch(),
                _buildFilter(),
                Expanded(
                  child: riwayat.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            16, 8, 16, 24,
                          ),
                          itemCount: riwayat.length,
                          itemBuilder: (context, index) {
                            return _buildRiwayatCard(
                              riwayat[index],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF3978C5),
            Color(0xFF24569A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Arsip Konseling',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.history_rounded,
                color: Colors.white70,
                size: 35,
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Pantau pengajuan yang sudah diproses.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  icon: Icons.folder_copy_outlined,
                  label: 'Total Riwayat',
                  value: semuaRiwayat.length.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryCard(
                  icon: Icons.check_circle_outline,
                  label: 'Diterima',
                  value: jumlahDiterima.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryCard(
                  icon: Icons.cancel_outlined,
                  label: 'Ditolak',
                  value: jumlahDitolak.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 21),
          const SizedBox(height: 9),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: TextField(
        onChanged: (value) {
          setState(() {
            kataKunci = value.trim();
          });
        },
        decoration: InputDecoration(
          hintText: 'Cari nama, kelas, atau alasan...',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: warnaUtama,
          ),
          suffixIcon: kataKunci.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      kataKunci = '';
                    });
                  },
                  icon: const Icon(Icons.close),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: warnaUtama,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilter() {
    final pilihan = ['Semua', 'Diterima', 'Ditolak'];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: pilihan.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = pilihan[index];
          final terpilih = filterStatus == status;

          return InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              setState(() {
                filterStatus = status;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(
                horizontal: 19,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: terpilih ? warnaUtama : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: terpilih
                      ? warnaUtama
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  if (terpilih) ...[
                    const Icon(
                      Icons.check_circle,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    status,
                    style: TextStyle(
                      color: terpilih
                          ? Colors.white
                          : Colors.grey.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRiwayatCard(
    Map<String, String> pengajuan,
  ) {
    final nama = pengajuan['nama'] ?? 'Nama siswa';
    final kelas = pengajuan['kelas'] ?? '-';
    final alasan = pengajuan['alasan'] ?? '-';
    final tanggal = pengajuan['tanggal'] ?? '-';
    final status = pengajuan['status'] ?? '-';
    final diterima = status == 'Diterima';

    final warnaStatus = diterima
        ? const Color(0xFF16845B)
        : const Color(0xFFD94343);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF233F66).withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showDetail(pengajuan),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F1FE),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _inisial(nama),
                      style: const TextStyle(
                        color: warnaUtama,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF243247),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Kelas $kelas',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: warnaStatus.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          diterima
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 13,
                          color: warnaStatus,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: TextStyle(
                            color: warnaStatus,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F8FC),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 18,
                      color: warnaUtama,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alasan konseling',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            alasan,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: Color(0xFF344054),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Tanggal pengajuan: $tanggal',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: warnaUtama,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetail(Map<String, String> pengajuan) {
    final nama = pengajuan['nama'] ?? 'Nama siswa';
    final kelas = pengajuan['kelas'] ?? '-';
    final status = pengajuan['status'] ?? '-';
    final diterima = status == 'Diterima';
    final warnaStatus = diterima
        ? const Color(0xFF16845B)
        : const Color(0xFFD94343);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.82,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F1FE),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _inisial(nama),
                        style: const TextStyle(
                          color: warnaUtama,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detail Riwayat',
                            style: TextStyle(
                              color: warnaUtama,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            nama,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kelas $kelas',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: warnaStatus.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        diterima
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: warnaStatus,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Pengajuan $status',
                          style: TextStyle(
                            color: warnaStatus,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow(
                  Icons.chat_bubble_outline,
                  'Alasan konseling',
                  pengajuan['alasan'] ?? '-',
                ),
                _buildDetailRow(
                  Icons.calendar_today_outlined,
                  'Tanggal pengajuan',
                  pengajuan['tanggal'] ?? '-',
                ),
                if (diterima) ...[
                  _buildDetailRow(
                    Icons.event_available_outlined,
                    'Tanggal jadwal',
                    pengajuan['jadwalTanggal'] ?? '-',
                  ),
                  _buildDetailRow(
                    Icons.access_time_rounded,
                    'Waktu konseling',
                    pengajuan['jadwalWaktu'] ?? '-',
                  ),
                  _buildDetailRow(
                    Icons.location_on_outlined,
                    'Tempat konseling',
                    pengajuan['jadwalTempat'] ?? '-',
                  ),
                ] else ...[
                  _buildDetailRow(
                    Icons.info_outline,
                    'Alasan penolakan',
                    pengajuan['alasanPenolakan'] ??
                        'Tidak ada keterangan',
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warnaUtama,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Tutup Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F1FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.info_outline,
              color: warnaUtama,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF26364A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _inisial(String nama) {
    final bagian = nama
        .trim()
        .split(RegExp(r'\s+'))
        .where((kata) => kata.isNotEmpty)
        .toList();

    if (bagian.isEmpty) return '?';
    if (bagian.length == 1) {
      return bagian.first[0].toUpperCase();
    }

    return '${bagian[0][0]}${bagian[1][0]}'.toUpperCase();
  }

  Widget _buildEmptyState() {
    final pesan = kataKunci.isNotEmpty
        ? 'Coba gunakan kata kunci pencarian yang berbeda.'
        : filterStatus == 'Semua'
            ? 'Pengajuan yang sudah diterima atau ditolak akan muncul di sini.'
            : 'Belum ada riwayat dengan status $filterStatus.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F1FE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history_rounded,
                size: 48,
                color: warnaUtama,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum Ada Riwayat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26364A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade600,
              ),
            ),
            if (kataKunci.isNotEmpty) ...[
              const SizedBox(height: 14),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    kataKunci = '';
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Hapus pencarian'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
