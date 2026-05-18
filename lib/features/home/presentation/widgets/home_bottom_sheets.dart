import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

          // Title & Divider
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style:
                      const TextStyle(fontSize: 10, color: AppColors.gray200),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Divider(color: AppColors.gray100, thickness: 1),
          const SizedBox(height: 15),

          // Grid menu
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 10,
            childAspectRatio: 116 / 108,
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
  final String? svgIcon;
  final String? textIcon;
  final String label;
  final bool isActive;
  final Widget? badge;
  final double? progress;

  const _SheetMenuItem({
    this.svgIcon,
    this.textIcon,
    required this.label,
    this.isActive = false,
    this.badge,
    this.progress,
  });
}

class _SheetMenuItemWidget extends StatelessWidget {
  final _SheetMenuItem item;

  const _SheetMenuItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Ellipse
          Positioned(
            left: -82,
            top: -16,
            child: Container(
              width: 198,
              height: 219,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon and Badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: item.isActive
                                  ? AppColors.dark
                                  : AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: item.progress != null
                                  ? [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : (item.isActive
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.05),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]),
                            ),
                          ),
                          if (item.progress != null)
                            CircularProgressIndicator(
                              value: item.progress,
                              color: const Color(0xFFFF5C5C),
                              backgroundColor: AppColors.white,
                              strokeWidth: 3.0,
                            ),
                          Center(
                            child: item.textIcon != null
                                ? Text(
                                    item.textIcon!,
                                    style: TextStyle(
                                      color: item.isActive
                                          ? AppColors.white
                                          : AppColors.gray300,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : (item.svgIcon != null
                                    ? SvgPicture.asset(
                                        item.svgIcon!,
                                        width: 20,
                                        height: 20,
                                        colorFilter: ColorFilter.mode(
                                          item.isActive
                                              ? AppColors.white
                                              : AppColors.gray300,
                                          BlendMode.srcIn,
                                        ),
                                      )
                                    : const SizedBox()),
                          ),
                        ],
                      ),
                    ),
                    if (item.badge != null)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: item.badge!,
                      ),
                  ],
                ),
                // Text
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: item.isActive ? AppColors.dark : AppColors.gray300,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildNumberBadge(String number) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: const Color(0xFFFF5C5C),
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.white, width: 2),
    ),
    child: Center(
      child: Text(
        number,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    ),
  );
}

Widget _buildIconBadge() {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: const Color(0xFFFF5C5C),
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.white, width: 2),
    ),
    child: const Center(
      child: Text(
        '!',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    ),
  );
}

// ─── 1. TAHAP PEMESANAN ───────────────────────────────────────────────────────

void _showPemesananSheet(BuildContext context) {
  _showBaseSheet(
    context: context,
    title: 'Tahap Pemesanan',
    subtitle: 'Daftar menu tahap pemesanan',
    items: [
      _SheetMenuItem(
        svgIcon: 'assets/icons/money-receive.svg',
        label: 'Booking\nFee',
        isActive: true,
        badge: _buildNumberBadge('3'),
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/empty-wallet.svg',
        label: 'Pesanan\nBelum Bayar',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/note-favorite-fill.svg',
        label: 'Riwayat\nPemesanan',
        isActive: false,
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
    items: [
      _SheetMenuItem(
        svgIcon: 'assets/icons/ruler-pen.svg',
        label: 'Tahap\nSPS',
        isActive: true,
        badge: _buildIconBadge(),
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/edit-2.svg',
        label: 'Tahap\nSPR',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/document-filled.svg',
        label: 'Tahap\nPPJB',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/note-2-fill.svg',
        label: 'Daftar\nDokumen',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/archive-book-fill.svg',
        label: 'Tahap\nSP3K',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/receipt-text-fill.svg',
        label: 'Bayar\nAngsuran',
        isActive: false,
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
    items: [
      _SheetMenuItem(
        textIcon: '100%',
        label: 'Tahap\nPersiapan',
        isActive: true,
        progress: 1.0,
      ),
      _SheetMenuItem(
        textIcon: '20%',
        label: 'Tahap\nPondasi & Struktur',
        isActive: true,
        progress: 0.2,
      ),
      _SheetMenuItem(
        textIcon: '30%',
        label: 'Tahap\nRumah Unfinished',
        isActive: true,
        progress: 0.3,
      ),
      _SheetMenuItem(
        textIcon: '40%',
        label: 'Tahap\nFinishing & Interior',
        isActive: true,
        progress: 0.4,
      ),
      const _SheetMenuItem(
        textIcon: '0%',
        label: 'Tahap\nPembersihan',
        isActive: true,
        progress: 0.0,
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
    items: [
      _SheetMenuItem(
        svgIcon: 'assets/icons/handshake-fill.svg',
        label: 'Tahap\nAkad',
        isActive: true,
        badge: _buildIconBadge(),
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/key.svg',
        label: 'Serah Terima\nBangunan',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/judge-fill.svg',
        label: 'Serah Terima\nLegalitas',
        isActive: false,
      ),
      const _SheetMenuItem(
        svgIcon: 'assets/icons/danger-2-fill.svg',
        label: 'Daftar\nKomplain',
        isActive: false,
      ),
    ],
  );
}
