import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/order_model.dart';

// ─── EVENTS ───────────────────────────────────────────────────────────────────

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadEmpty extends HomeEvent {
  const HomeLoadEmpty();
}

class HomeLoadData extends HomeEvent {
  const HomeLoadData();
}

class HomeExploreProperty extends HomeEvent {
  const HomeExploreProperty();
}

class HomeTabChanged extends HomeEvent {
  final int tabIndex;
  const HomeTabChanged(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

// ─── STATES ───────────────────────────────────────────────────────────────────

enum HomeDisplayState { empty, loaded, penalty }

class HomeState extends Equatable {
  final HomeDisplayState displayState;
  final List<OrderModel> orders;
  final List<BannerModel> banners;
  final int
      selectedTab; // 0=Pemesanan, 1=Administrasi, 2=Pembangunan, 3=AkadSerahTerima
  final bool isLoading;

  const HomeState({
    this.displayState = HomeDisplayState.empty,
    this.orders = const [],
    this.banners = const [],
    this.selectedTab = 0,
    this.isLoading = false,
  });

  bool get isEmpty => displayState == HomeDisplayState.empty;
  bool get hasPenalty => displayState == HomeDisplayState.penalty;

  HomeState copyWith({
    HomeDisplayState? displayState,
    List<OrderModel>? orders,
    List<BannerModel>? banners,
    int? selectedTab,
    bool? isLoading,
  }) {
    return HomeState(
      displayState: displayState ?? this.displayState,
      orders: orders ?? this.orders,
      banners: banners ?? this.banners,
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [displayState, orders, banners, selectedTab, isLoading];
}

// ─── BLOC ─────────────────────────────────────────────────────────────────────

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeLoadEmpty>(_onLoadEmpty);
    on<HomeLoadData>(_onLoadData);
    on<HomeExploreProperty>(_onExploreProperty);
    on<HomeTabChanged>(_onTabChanged);
  }

  void _onLoadEmpty(HomeLoadEmpty event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      displayState: HomeDisplayState.empty,
      orders: [],
      banners: DummyData.banners,
    ));
  }

  void _onLoadData(HomeLoadData event, Emitter<HomeState> emit) {
    emit(state.copyWith(isLoading: true));

    // Simulate loading
    final orders = DummyData.orders;
    final hasPenalty = orders.any((o) => o.hasPenalty);

    emit(state.copyWith(
      displayState:
          hasPenalty ? HomeDisplayState.penalty : HomeDisplayState.loaded,
      orders: orders,
      banners: DummyData.banners,
      isLoading: false,
    ));
  }

  void _onExploreProperty(HomeExploreProperty event, Emitter<HomeState> emit) {
    add(const HomeLoadData());
  }

  void _onTabChanged(HomeTabChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }
}
