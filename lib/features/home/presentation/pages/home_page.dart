import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          backgroundColor: AppColors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: state.isEmpty
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 40, 25, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HomeAppBar(),
                                const SizedBox(height: 30),
                                BannerCarousel(banners: state.banners),
                                const SizedBox(height: 30),
                                const _PesananHeader(hasOrders: false),
                                const SizedBox(height: 5),
                                EmptyOrderWidget(
                                  onExplore: () => context
                                      .read<HomeBloc>()
                                      .add(const HomeExploreProperty()),
                                ),
                              ],
                            ),
                          ),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: IntrinsicHeight(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const HomeAppBar(),
                                        const SizedBox(height: 15),
                                        BannerCarousel(banners: state.banners),
                                        const SizedBox(height: 10),
                                        const _PesananHeader(hasOrders: true),
                                        const SizedBox(height: 8),
                                        OrderPipelineTracker(
                                          selectedIndex: state.selectedTab,
                                        ),
                                        const SizedBox(height: 8),
                                        _OrderSlider(orders: state.orders),
                                        const SizedBox(height: 10),
                                        Expanded(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(minHeight: 280),
                                            child: const HomeMenuGrid(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.dark,
              ),
            ),
            Text(
              'Daftar pesanan terbaru anda',
              style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
            ),
          ],
        ),
        if (hasOrders)
          SvgPicture.asset(
            'assets/icons/arrow-right.svg',
            colorFilter: const ColorFilter.mode(AppColors.dark, BlendMode.srcIn),
            width: 16,
            height: 16,
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

  void _goNext() {
    if (_current < widget.orders.length - 1) setState(() => _current++);
  }

  void _goPrev() {
    if (_current > 0) setState(() => _current--);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onHorizontalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0;
            if (velocity < -100) _goNext();
            if (velocity > 100) _goPrev();
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: KeyedSubtree(
              key: ValueKey(_current),
              child: OrderCard(order: widget.orders[_current]),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Square dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.orders.asMap().entries.map((entry) {
            final isActive = _current == entry.key;
            return Container(
              width: isActive ? 16 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              color: isActive ? AppColors.dark : AppColors.gray100,
            );
          }).toList(),
        ),
      ],
    );
  }
}
