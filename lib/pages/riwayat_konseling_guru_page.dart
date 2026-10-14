
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
  String filterStatus = 'Semua';

  List<Map<String, String>> get riwayatKonseling {
    return widget.daftarPengajuan.where((pengajuan) {
      final status = pengajuan['status'] ?? '';

      // Riwayat hanya menampilkan pengajuan yang sudah diproses.
      final sudahDiproses =
          status == 'Diterima' || status == 'Ditolak';

      if (!sudahDiproses) return false;

      if (filterStatus == 'Semua') return true;

      return status == filterStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final riwayat = riwayatKonseling;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Riwayat Konseling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF3978C5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Ringkasan jumlah riwayat
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF3978C5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Pengajuan Konseling',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${riwayat.length} pengajuan telah diproses',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Filter status
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Row(
              children: [
                _buildFilterChip('Semua'),
                const SizedBox(width: 8),
                _buildFilterChip('Diterima'),
                const SizedBox(width: 8),
                _buildFilterChip('Ditolak'),
              ],
            ),
          ),

          // Daftar riwayat
          Expanded(
            child: riwayat.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: riwayat.length,
                    itemBuilder: (context, index) {
                      final pengajuan = riwayat[index];
                      return _buildRiwayatCard(pengajuan);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String status) {
    final terpilih = filterStatus == status;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            filterStatus = status;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            color: terpilih
                ? const Color(0xFF3978C5)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: terpilih
                  ? const Color(0xFF3978C5)
                  : Colors.grey.shade300,
            ),
          ),
          child: Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: terpilih ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight:
                  terpilih ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRiwayatCard(Map<String, String> pengajuan) {
    final nama = pengajuan['nama'] ?? 'Nama siswa';
    final kelas = pengajuan['kelas'] ?? '-';
    final alasan = pengajuan['alasan'] ?? '-';
    final tanggalPengajuan = pengajuan['tanggal'] ?? '-';
    final status = pengajuan['status'] ?? '-';

    final diterima = status == 'Diterima';

    // Sesuaikan dengan warna status.
    final warnaStatus =
        diterima ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFE3EEFC),
                  child: Icon(
                    Icons.person,
                    color: const Color(0xFF3978C5),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: warnaStatus.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: warnaStatus,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 26),

            _buildInfoRow(
              Icons.chat_bubble_outline,
              'Alasan konseling',
              alasan,
            ),
            const SizedBox(height: 10),
            _buildInfoRow(
              Icons.calendar_today_outlined,
              'Tanggal pengajuan',
              tanggalPengajuan,
            ),

            if (diterima) ...[
              const SizedBox(height: 10),
              _buildInfoRow(
                Icons.event_available_outlined,
                'Tanggal jadwal',
                pengajuan['jadwalTanggal'] ?? '-',
              ),
              const SizedBox(height: 10),
              _buildInfoRow(
                Icons.access_time,
                'Waktu',
                pengajuan['jadwalWaktu'] ?? '-',
              ),
              const SizedBox(height: 10),
              _buildInfoRow(
                Icons.location_on_outlined,
                'Tempat',
                pengajuan['jadwalTempat'] ?? '-',
              ),
            ] else ...[
              const SizedBox(height: 10),
              _buildInfoRow(
                Icons.info_outline,
                'Alasan penolakan',
                pengajuan['alasanPenolakan'] ??
                    'Tidak ada keterangan',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF3978C5),
        ),
        const SizedBox(width: 10),
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
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Riwayat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pengajuan yang sudah diterima atau ditolak '
              'akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
