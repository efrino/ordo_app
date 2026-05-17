import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

// ─── BOTTOM SHEET HELPER ──────────────────────────────────────────────────────

void showHomeBottomSheet(BuildContext context, int menuIndex) {
  switch (menuIndex) {
    case 0:
      _showPemesananSheet(context);
      break;
    case 1:
      _showAdministrasiSheet(context);
      break;
    case 2:
      _showPembangunanSheet(context);
      break;
    case 3:
      _showAkadSerahTerimaSheet(context);
      break;
  }
}

// ─── BASE SHEET ───────────────────────────────────────────────────────────────

void _showBaseSheet({
  required BuildContext context,
  required String title,
  required String subtitle,
  required List<_SheetMenuItem> items,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _BaseBottomSheet(
      title: title,
      subtitle: subtitle,
      items: items,
    ),
  );
}

class _BaseBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<_SheetMenuItem> items;

  const _BaseBottomSheet({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(25, 16, 25, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: AppColors.gray200),
          ),
          const SizedBox(height: 20),

          // Grid menu
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
            children:
                items.map((item) => _SheetMenuItemWidget(item: item)).toList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SheetMenuItem {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? bgColor;

  const _SheetMenuItem({
    required this.icon,
    required this.label,
    this.iconColor,
    this.bgColor,
  });
}

class _SheetMenuItemWidget extends StatelessWidget {
  final _SheetMenuItem item;

  const _SheetMenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: item.bgColor ?? AppColors.background,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            item.icon,
            color: item.iconColor ?? AppColors.dark,
            size: 26,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.dark,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}

// ─── 1. TAHAP PEMESANAN ───────────────────────────────────────────────────────

void _showPemesananSheet(BuildContext context) {
  _showBaseSheet(
    context: context,
    title: 'Tahap Pemesanan',
    subtitle: 'Daftar menu tahap pemesanan',
    items: const [
      _SheetMenuItem(
        icon: Icons.attach_money_rounded,
        label: 'Booking\nFee',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.receipt_long_outlined,
        label: 'Pesanan\nBelum Bayar',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.headset_mic_outlined,
        label: 'Keluhan\nPemesanan',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
    ],
  );
}

// ─── 2. TAHAP ADMINISTRASI ────────────────────────────────────────────────────

void _showAdministrasiSheet(BuildContext context) {
  _showBaseSheet(
    context: context,
    title: 'Tahap Administrasi',
    subtitle: 'Daftar menu tahap administrasi',
    items: const [
      _SheetMenuItem(
        icon: Icons.article_outlined,
        label: 'Tahap\nSPK',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.description_outlined,
        label: 'Tahap\nSPA',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.file_copy_outlined,
        label: 'Tahap\nPPJB',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.folder_outlined,
        label: 'Daftar\nDokumen',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.account_balance_outlined,
        label: 'Tahap\nBPSA',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.payments_outlined,
        label: 'Muat\nAngsuran',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
    ],
  );
}

// ─── 3. TAHAP PEMBANGUNAN ─────────────────────────────────────────────────────

void _showPembangunanSheet(BuildContext context) {
  _showBaseSheet(
    context: context,
    title: 'Tahap Pembangunan',
    subtitle: 'Daftar menu tahap pembangunan rumah',
    items: const [
      _SheetMenuItem(
        icon: Icons.shopping_bag_outlined,
        label: 'Tahap\nPesanan',
        iconColor: Color(0xFF9ACA3E),
        bgColor: Color(0xFFF0F8E0),
      ),
      _SheetMenuItem(
        icon: Icons.calculate_outlined,
        label: 'Proses &\nSimulasi',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.home_work_outlined,
        label: 'Rumah\nDibangun',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.design_services_outlined,
        label: 'Finishing &\nInterior',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.build_outlined,
        label: 'Tahap\nPerbaikan',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
    ],
  );
}

// ─── 4. TAHAP AKAD & SERAH TERIMA ────────────────────────────────────────────

void _showAkadSerahTerimaSheet(BuildContext context) {
  _showBaseSheet(
    context: context,
    title: 'Tahap Akad & Serah Terima',
    subtitle: 'Daftar menu tahap akad & serah terima',
    items: const [
      _SheetMenuItem(
        icon: Icons.handshake_outlined,
        label: 'Tahap\nAkad',
        iconColor: Color(0xFF9ACA3E),
        bgColor: Color(0xFFF0F8E0),
      ),
      _SheetMenuItem(
        icon: Icons.home_outlined,
        label: 'Serah Terima\nBangunan',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.gavel_outlined,
        label: 'Tahap\nLegalitas',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
      _SheetMenuItem(
        icon: Icons.list_alt_outlined,
        label: 'Daftar\nKoneksi',
        iconColor: Color(0xFF334A34),
        bgColor: Color(0xFFE8F0E8),
      ),
    ],
  );
}
