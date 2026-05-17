import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/order_model.dart';

// ─── ORDER STATUS TAB ─────────────────────────────────────────────────────────

class OrderStatusTab extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const OrderStatusTab({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const _tabs = [
    'Pemesanan',
    'Administrasi',
    'Pembangunan',
    'Akad Terima',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(entry.key),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.dark : AppColors.gray100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                entry.value,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.gray300,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── ORDER CARD ───────────────────────────────────────────────────────────────

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String get _statusLabel {
    switch (order.status) {
      case OrderStatus.pemesanan:
        return 'Pemesanan';
      case OrderStatus.administrasi:
        return 'Administrasi';
      case OrderStatus.pembangunan:
        return 'Pembangunan';
      case OrderStatus.akadSerahTerima:
        return 'Akad & Serah';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.gray200,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _statusLabel,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Content row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.home_work_outlined,
                  color: AppColors.gray200,
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.propertyName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: AppColors.gray200),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            order.address,
                            style: AppTextStyles.caption,
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
                            size: 12, color: AppColors.gray200),
                        const SizedBox(width: 3),
                        Text(order.date, style: AppTextStyles.caption),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatCurrency(order.price),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
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
                      'Denda Rp ${NumberFormat('#,###', 'id_ID').format(order.penaltyAmount)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Tertunggak',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── EMPTY ORDER WIDGET ───────────────────────────────────────────────────────

class EmptyOrderWidget extends StatelessWidget {
  final VoidCallback onExplore;

  const EmptyOrderWidget({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          // Illustration Box
          Image.asset(
            'assets/icons/empty-state.png',
            width: 318,
            height: 196,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),

          // Text Wrapper
          const Column(
            children: [
              Text(
                'Pesanan Kosong',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334A34),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Ayo tambahkan pesanan baru',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9B9B9B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Explore button
          GestureDetector(
            onTap: onExplore,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF334A34),
                borderRadius: BorderRadius.circular(39),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Eksplor Properti',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}
