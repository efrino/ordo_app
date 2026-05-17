import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Menyembunyikan navigation bar bawaan HP (bottom system UI)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  runApp(const OrdoApp());
}

class OrdoApp extends StatelessWidget {
  const OrdoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORDO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: BlocProvider(
        create: (_) => HomeBloc()..add(const HomeLoadEmpty()),
        child: const HomePage(),
      ),
    );
  }
}
