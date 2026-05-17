import 'package:flutter/material.dart';
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

  // Placeholder image colors per menu
  static const _menuColors = [
    Color(0xFF8BC34A),
    Color(0xFF607D8B),
    Color(0xFFFF8F00),
    Color(0xFF78909C),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dark,
                  ),
                ),
                Text(
                  'Daftar menu transaksi',
                  style: TextStyle(fontSize: 12, color: AppColors.gray400),
                ),
              ],
            ),
            Icon(Icons.grid_view_rounded, color: AppColors.dark, size: 24),
          ],
        ),
        const SizedBox(height: 15),

        // 2x2 Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: _menus.map((menu) {
            return GestureDetector(
              onTap: () => showHomeBottomSheet(context, menu.index),
              child: _MenuCard(
                menu: menu,
                bgColor: _menuColors[menu.index],
              ),
            );
          }).toList(),
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
  final Color bgColor;

  const _MenuCard({super.key, required this.menu, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray100, width: 0.5),
      ),
      child: Stack(
        children: [
          // Background color block (right half simulation)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 80,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.15),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(12),
                ),
              ),
            ),
          ),

          // Image placeholder
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIcon(menu.index),
                color: bgColor,
                size: 36,
              ),
            ),
          ),

          // Progress indicator (top left)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${(menu.index + 1) * 25}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Label
          Positioned(
            left: 10,
            bottom: 10,
            right: 75,
            child: Text(
              menu.label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.dark,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.business_outlined;
      case 2:
        return Icons.construction_outlined;
      case 3:
        return Icons.door_front_door_outlined;
      default:
        return Icons.home_outlined;
    }
  }
}
