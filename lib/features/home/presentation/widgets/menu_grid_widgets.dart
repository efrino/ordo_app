import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_theme.dart';
import 'home_bottom_sheets.dart';

class HomeMenuGrid extends StatelessWidget {
  const HomeMenuGrid({super.key});

  static const _menus = [
    _MenuItem(label: 'Tahap\nPemesanan', index: 0),
    _MenuItem(label: 'Tahap\nAdministrasi', index: 1),
    _MenuItem(label: 'Tahap\nPembangunan', index: 2),
    _MenuItem(label: 'Tahap\nAkad & Serah Terima', index: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
                Text(
                  'Daftar menu transaksi',
                  style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/icons/category-fill.svg',
              colorFilter: const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
              width: 22,
              height: 22,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 2x2 Grid utilizing Expanded to fit exact remaining space
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showHomeBottomSheet(context, 0),
                        child: _MenuCard(menu: _menus[0]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showHomeBottomSheet(context, 1),
                        child: _MenuCard(menu: _menus[1]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showHomeBottomSheet(context, 2),
                        child: _MenuCard(menu: _menus[2]),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showHomeBottomSheet(context, 3),
                        child: _MenuCard(menu: _menus[3]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final String label;
  final int index;
  const _MenuItem({required this.label, required this.index});
}

class _MenuCard extends StatelessWidget {
  final _MenuItem menu;

  const _MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    // Styling logic based on reference
    final isFirst = menu.index == 0;
    final isLocked = menu.index >= 2; // 0% progress — not yet started

    final backgroundColor = isFirst
        ? AppColors.dark
        : isLocked
            ? AppColors.neutral100
            : AppColors.white;
    final textColor = isFirst
        ? AppColors.white
        : isLocked
            ? AppColors.gray300
            : AppColors.dark;

    // Progress circle styling
    Color circleBorderColor;
    Color circleBgColor;
    Color circleTextColor;
    String progressText;

    if (menu.index == 0) {
      circleBorderColor = AppColors.red;
      circleBgColor = AppColors.dark;
      circleTextColor = AppColors.white;
      progressText = '100%';
    } else if (menu.index == 1) {
      circleBorderColor = AppColors.accentGreen;
      circleBgColor = AppColors.white;
      circleTextColor = AppColors.dark;
      progressText = '50%';
    } else {
      circleBorderColor = AppColors.gray200;
      circleBgColor = isLocked ? AppColors.neutral100 : AppColors.white;
      circleTextColor = AppColors.gray300;
      progressText = '0%';
    }

    // Local asset images from Figma
    const imagePaths = [
      'assets/images/tahap-pemesanan.png',
      'assets/images/tahap-administrasi.png',
      'assets/images/tahap-pembangunan.png',
      'assets/images/tahap-akad.png',
    ];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Background accent for the first card
          if (isFirst)
            Positioned(
              right: -20,
              bottom: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white.withValues(alpha: 0.1),
                ),
              ),
            ),

          // Image on the bottom right
          Positioned(
            right: 0,
            bottom: 0,
            width: 110,
            height: 110,
            child: Image.asset(
              imagePaths[menu.index],
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
              errorBuilder: (_, __, ___) => Icon(
                _getFallbackIcon(menu.index),
                color: isFirst
                    ? AppColors.white.withValues(alpha: 0.5)
                    : AppColors.gray200,
                size: 50,
              ),
            ),
          ),

          // Progress Circle (Bottom Left)
          Positioned(
            left: 12,
            bottom: 12,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: circleBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: circleBorderColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  progressText,
                  style: TextStyle(
                    color: circleTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          // Label (Top Left)
          Positioned(
            left: 12,
            top: 12,
            right: 12,
            child: Text(
              menu.label,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: textColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFallbackIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.folder;
      case 2:
        return Icons.construction;
      case 3:
        return Icons.door_front_door;
      default:
        return Icons.home;
    }
  }
}
