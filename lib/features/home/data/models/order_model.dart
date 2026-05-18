import 'package:equatable/equatable.dart';

enum OrderStatus { pemesanan, administrasi, pembangunan, akadSerahTerima }

class OrderModel extends Equatable {
  final String id;
  final String propertyName;
  final String address;
  final String date;
  final double price;
  final OrderStatus status;
  final double? penaltyAmount;
  final int? delayDays;
  final bool hasPenalty;
  final String? imagePath;

  const OrderModel({
    required this.id,
    required this.propertyName,
    required this.address,
    required this.date,
    required this.price,
    required this.status,
    this.penaltyAmount,
    this.delayDays,
    this.hasPenalty = false,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        id,
        propertyName,
        address,
        date,
        price,
        status,
        penaltyAmount,
        delayDays,
        hasPenalty,
        imagePath,
      ];
}

class BannerModel extends Equatable {
  final String title;
  final String subtitle;
  final String period;
  final int color;
  final String imagePath;

  const BannerModel({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.color,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [title, subtitle, period, color, imagePath];
}

class DummyData {
  static List<BannerModel> get banners => [
        const BannerModel(
          title: '20% Diskon',
          subtitle: 'American House',
          period: 'Periode 19 Nov 2023 s/d 15 Des 2023',
          color: 0xFF39413D,
          imagePath: 'assets/images/carousel-1.png',
        ),
        const BannerModel(
          title: '20% Discount',
          subtitle: 'American House',
          period: 'Periode 19 Nov 2023 s/d 15 Des 2023',
          color: 0xFF9ACA3E,
          imagePath: 'assets/images/carousel-2.png',
        ),
      ];

  static List<OrderModel> get orders => [
        const OrderModel(
          id: '#88172647B23',
          propertyName: 'Candra Bhirawa',
          address: 'Lohos, Kavling A1, Blok B No. 6',
          date: '25/11/2022, 09:00',
          price: 850000000,
          status: OrderStatus.pembangunan,
          hasPenalty: false,
          imagePath: 'assets/images/candra-bhirawa.png',
        ),
        const OrderModel(
          id: '#88172647B24',
          propertyName: 'Bukit Raya Residence',
          address: 'Jlagran, Kavling A1, Blok D No. 6',
          date: '25/10/2023, 09:00',
          price: 985799500,
          status: OrderStatus.administrasi,
          hasPenalty: true,
          penaltyAmount: 5540000,
          delayDays: 7,
          imagePath: 'assets/images/bukit-raya-residence.png',
        ),
        const OrderModel(
          id: '#88172647B25',
          propertyName: 'Grand Harmony',
          address: 'Sidoarjo, Kavling B2, Blok C No. 3',
          date: '10/12/2023, 10:00',
          price: 1200000000,
          status: OrderStatus.pembangunan,
          hasPenalty: true,
          penaltyAmount: 750000,
          delayDays: 3,
          imagePath: 'assets/images/placeholder-active-transaction.png',
        ),
      ];
}
