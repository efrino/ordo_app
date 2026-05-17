import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/order_model.dart';

// ─── HOME APP BAR ─────────────────────────────────────────────────────────────

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6A8B92),
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF6A8B92),
                child: Icon(Icons.person, color: AppColors.white, size: 28),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),

        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Temukan Hunian Impian',
                style: AppTextStyles.heading2.copyWith(fontSize: 16),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                'Agen Properti Terbaik',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),

        // Bell icon
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC5D1C6).withOpacity(0.16),
                blurRadius: 11,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications_outlined,
                  color: AppColors.dark, size: 20),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── BANNER CAROUSEL ──────────────────────────────────────────────────────────

class BannerCarousel extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 155,
            viewportFraction: 0.88,
            padEnds: false,
            enableInfiniteScroll: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, _) => setState(() => _current = index),
          ),
          items: widget.banners
              .map((banner) => _BannerItem(banner: banner))
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.banners.asMap().entries.map((entry) {
            return Container(
              width: _current == entry.key ? 16 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color:
                    _current == entry.key ? AppColors.dark : AppColors.gray100,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _BannerItem extends StatelessWidget {
  final BannerModel banner;

  const _BannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Color(banner.color),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // House illustration placeholder
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.3,
              child: Icon(
                Icons.home,
                size: 160,
                color: AppColors.white.withOpacity(0.4),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  banner.title,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  banner.subtitle,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: AppColors.white, size: 12),
                    const SizedBox(width: 5),
                    Text(
                      banner.period,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── BOTTOM NAV BAR ───────────────────────────────────────────────────────────

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItem(icon: Icons.home_filled, label: 'Home'),
      _NavItem(icon: Icons.apartment_outlined, label: 'Properti'),
      _NavItem(icon: Icons.description_outlined, label: 'Dokumen'),
      _NavItem(icon: Icons.shopping_cart_outlined, label: 'Pesanan'),
      _NavItem(imagePath: 'assets/icons/profile.png', label: 'Profil'),
    ];

    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == currentIndex;
          return GestureDetector(
            onTap: () => onTap(entry.key),
            child: _NavMenuWidget(
              item: entry.value,
              isSelected: isSelected,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final IconData? icon;
  final String? imagePath;
  final String label;
  const _NavItem({this.icon, this.imagePath, required this.label});
}

class _NavMenuWidget extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;

  const _NavMenuWidget({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (item.imagePath != null)
          Image.asset(
            item.imagePath!,
            width: 24,
            height: 24,
            color: isSelected ? AppColors.dark : AppColors.gray200,
          )
        else if (item.icon != null)
          Icon(
            item.icon,
            color: isSelected ? AppColors.dark : AppColors.gray200,
            size: 24,
          ),
        const SizedBox(height: 20),
        // Indicator bar
        Container(
          width: 61,
          height: 11,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.dark : Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(30.5, 11),
              topRight: Radius.elliptical(30.5, 11),
            ),
          ),
          child: isSelected
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
