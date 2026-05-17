import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../bloc/home_bloc.dart';
import '../../data/models/order_model.dart';
import '../widgets/home_widgets.dart';
import '../widgets/order_widgets.dart';
import '../widgets/menu_grid_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: state.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // App Bar
                              const HomeAppBar(),
                              const SizedBox(height: 30),

                              // Banner
                              BannerCarousel(banners: state.banners),
                              const SizedBox(height: 30),

                              // Pesanan Terbaru Header
                              const _PesananHeader(hasOrders: false),
                              const SizedBox(height: 20),

                              // Empty Order Content
                              EmptyOrderWidget(
                                onExplore: () => context
                                    .read<HomeBloc>()
                                    .add(const HomeExploreProperty()),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // App Bar
                              const HomeAppBar(),
                              const SizedBox(height: 30),

                              // Banner
                              BannerCarousel(banners: state.banners),
                              const SizedBox(height: 30),

                              // Pesanan Terbaru Header
                              const _PesananHeader(hasOrders: true),
                              const SizedBox(height: 20),

                              // Tab filter
                              OrderStatusTab(
                                selectedIndex: state.selectedTab,
                                onChanged: (i) => context
                                    .read<HomeBloc>()
                                    .add(HomeTabChanged(i)),
                              ),
                              const SizedBox(height: 15),

                              // Order slider (3 items)
                              _OrderSlider(orders: state.orders),
                              const SizedBox(height: 30),

                              // Menu Grid
                              const HomeMenuGrid(),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                ),

                // Bottom NavBar
                HomeBottomNavBar(
                  currentIndex: _navIndex,
                  onTap: (i) => setState(() => _navIndex = i),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── PESANAN HEADER ───────────────────────────────────────────────────────────

class _PesananHeader extends StatelessWidget {
  final bool hasOrders;

  const _PesananHeader({required this.hasOrders});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesanan Terbaru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.dark,
              ),
            ),
            Text(
              'Daftar pesanan terbaru anda',
              style: TextStyle(fontSize: 12, color: AppColors.gray400),
            ),
          ],
        ),
        if (hasOrders)
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.dark,
            size: 18,
          ),
      ],
    );
  }
}

// ─── ORDER SLIDER ─────────────────────────────────────────────────────────────

class _OrderSlider extends StatefulWidget {
  final List<OrderModel> orders;

  const _OrderSlider({required this.orders});

  @override
  State<_OrderSlider> createState() => _OrderSliderState();
}

class _OrderSliderState extends State<_OrderSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: null, // auto height
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, _) => setState(() => _current = index),
          ),
          items: widget.orders
              .map((order) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: OrderCard(order: order),
                  ))
              .toList(),
        ),
        const SizedBox(height: 10),

        // Dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.orders.asMap().entries.map((entry) {
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
