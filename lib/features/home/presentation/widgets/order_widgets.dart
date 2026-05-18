import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/order_model.dart';

// ─── ORDER PIPELINE TRACKER ─────────────────────────────────────────────────────

class OrderPipelineTracker extends StatelessWidget {
  final int selectedIndex;

  const OrderPipelineTracker({
    super.key,
    required this.selectedIndex,
  });

  static const _steps = [
    'Pemesanan',
    'Administrasi',
    'Pembangunan',
    'Serah Terima',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            final stepIndex = index ~/ 2;
            final isSolid = (stepIndex + 1) <= selectedIndex;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 2,
                  child: CustomPaint(
                    painter: _DashedLinePainter(
                      color: isSolid ? AppColors.accentGreen : AppColors.gray200,
                      solid: isSolid,
                    ),
                  ),
                ),
              ),
            );
          }
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex < selectedIndex;
          final isCurrent = stepIndex == selectedIndex;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                isCompleted
                    ? 'assets/icons/tick-circle.svg'
                    : isCurrent
                        ? 'assets/icons/time-circle.svg'
                        : 'assets/icons/dot-circle.svg',
                colorFilter: ColorFilter.mode(
                  isCompleted
                      ? AppColors.accentGreen
                      : isCurrent
                          ? AppColors.dark
                          : AppColors.gray200,
                  BlendMode.srcIn,
                ),
                width: 18,
                height: 18,
              ),
              const SizedBox(height: 4),
              Text(
                _steps[stepIndex],
                textAlign: TextAlign.center,
                style: AppTextStyles.textXSRegular.copyWith(
                  fontSize: 9,
                  fontWeight: (isCompleted || isCurrent) ? FontWeight.w500 : FontWeight.w400,
                  color: (isCompleted || isCurrent) ? AppColors.dark : AppColors.gray300,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─── DASHED LINE PAINTER ─────────────────────────────────────────────────────

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final bool solid;

  const _DashedLinePainter({required this.color, this.solid = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    if (solid) {
      canvas.drawLine(Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), paint);
      return;
    }

    const dashWidth = 4.0;
    const gapWidth = 3.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset((x + dashWidth).clamp(0, size.width), size.height / 2),
        paint,
      );
      x += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter old) =>
      old.color != color || old.solid != solid;
}

// ─── ORDER CARD ───────────────────────────────────────────────────────────────

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.id,
                style: AppTextStyles.textXSRegular
                    .copyWith(color: AppColors.gray200),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Komersil',
                  style: AppTextStyles.textXSMedium
                      .copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Content row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Property image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: order.imagePath != null
                    ? Image.asset(
                        order.imagePath!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _imageFallback(),
                      )
                    : _imageFallback(),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/building-unfill.svg',
                          colorFilter: const ColorFilter.mode(
                              AppColors.gray200, BlendMode.srcIn),
                          width: 11,
                          height: 11,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          order.propertyName,
                          style: AppTextStyles.textSSemiBold
                              .copyWith(color: AppColors.dark),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 11, color: AppColors.gray200),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            order.address,
                            style: AppTextStyles.textXSRegular
                                .copyWith(color: AppColors.textSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined,
                            size: 11, color: AppColors.gray200),
                        const SizedBox(width: 3),
                        Text(
                          order.date,
                          style: AppTextStyles.textXSRegular
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatCurrency(order.price),
                      style: AppTextStyles.textMSemiBold
                          .copyWith(color: AppColors.dark),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Penalty section
          if (order.hasPenalty && order.penaltyAmount != null) ...[
            const SizedBox(height: 10),
            const Divider(color: AppColors.gray100, height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        size: 14, color: AppColors.red),
                    const SizedBox(width: 5),
                    Text(
                      'Denda ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(order.penaltyAmount)}',
                      style: AppTextStyles.textXSMedium
                          .copyWith(color: AppColors.red),
                    ),
                  ],
                ),
                if (order.delayDays != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Terlambat ${order.delayDays} hari',
                      style: AppTextStyles.textXSMedium
                          .copyWith(color: AppColors.white),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.home_work_outlined,
          color: AppColors.gray200, size: 28),
    );
  }
}

// ─── EMPTY ORDER WIDGET ───────────────────────────────────────────────────────

class EmptyOrderWidget extends StatelessWidget {
  final VoidCallback onExplore;

  const EmptyOrderWidget({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'assets/icons/empty-state.png',
            width: 270,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            'Pesanan Kosong',
            style: AppTextStyles.textLSemiBold.copyWith(color: AppColors.dark),
          ),
          const SizedBox(height: 4),
          Text(
            'Ayo tambahkan pesanan baru',
            style:
                AppTextStyles.textSRegular.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onExplore,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: BorderRadius.circular(39),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search, color: AppColors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Eksplor Properti',
                    style: AppTextStyles.textLMedium
                        .copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
