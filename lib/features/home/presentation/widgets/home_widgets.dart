import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 1.5),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/justin.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const CircleAvatar(
                backgroundColor: Color(0xFF6A8B92),
                child: Icon(Icons.person, color: AppColors.white, size: 24),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Temukan\nHunian Impian',
                style: AppTextStyles.textSMedium,
                maxLines: 2,
              ),
              const SizedBox(height: 2),
              Text(
                'Agen Properti Terbaik',
                style: AppTextStyles.textXSRegular
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),

        // Bell icon
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC5D1C6).withValues(alpha: 0.16),
                blurRadius: 11,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/bell-fill.svg',
                colorFilter:
                    const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
                width: 22,
                height: 22,
              ),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: AppTextStyles.textXSRegular.copyWith(
                        color: AppColors.white,
                        fontSize: 7,
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
            viewportFraction: 0.93,
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
          // House image on the right
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.asset(
                banner.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppColors.gray200),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      banner.title.split(' ')[0],
                      style: AppTextStyles.textXLSemiBold
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      banner.title.split(' ').skip(1).join(' '),
                      style: AppTextStyles.textSRegular
                          .copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  banner.subtitle,
                  style: AppTextStyles.textLSemiBold
                      .copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        color: AppColors.white, size: 10),
                    const SizedBox(width: 5),
                    Text(
                      banner.period,
                      style: AppTextStyles.textXSLight
                          .copyWith(color: AppColors.white),
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
      _NavItem(
        activeSvgPath: 'assets/icons/home-filled.svg',
        inactiveSvgPath: 'assets/icons/home-outline.svg',
        label: 'Home',
      ),
      _NavItem(
        activeSvgPath: 'assets/icons/building-fill.svg',
        inactiveSvgPath: 'assets/icons/building-unfill.svg',
        label: 'Properti',
      ),
      _NavItem(
        activeSvgPath: 'assets/icons/document-filled.svg',
        inactiveSvgPath: 'assets/icons/document-outline.svg',
        label: 'Dokumen',
      ),
      _NavItem(
        activeSvgPath: 'assets/icons/cart-fill.svg',
        inactiveSvgPath: 'assets/icons/cart-unfill.svg',
        label: 'Pesanan',
      ),
      _NavItem(
        activeSvgPath: 'assets/icons/person-fill.svg',
        inactiveSvgPath: 'assets/icons/person-unfill.svg',
        label: 'Profil',
      ),
    ];

    return Container(
      height: 72,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: items.asMap().entries.map((entry) {
          final isSelected = entry.key == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(entry.key),
              child: _NavMenuWidget(
                item: entry.value,
                isSelected: isSelected,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final String activeSvgPath;
  final String inactiveSvgPath;
  final String label;
  const _NavItem({
    required this.activeSvgPath,
    required this.inactiveSvgPath,
    required this.label,
  });
}

class _NavMenuWidget extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;

  const _NavMenuWidget({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          isSelected ? item.activeSvgPath : item.inactiveSvgPath,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.dark : AppColors.gray300,
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
        const SizedBox(height: 16),
        Container(
          width: 48,
          height: 10,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.dark : Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(24, 10),
              topRight: Radius.elliptical(24, 10),
            ),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
