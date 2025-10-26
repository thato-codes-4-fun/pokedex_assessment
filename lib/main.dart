import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokedex_assessment/core/auth/auth_wrapper.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';

import 'package:pokedex_assessment/core/theme/app_theme.dart';
import 'package:pokedex_assessment/firebase_options.dart';
import 'package:pokedex_assessment/services/local/favorite_service.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/favourite_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final favoriteService = await FavoriteService.create();
  final themeVM = ThemeViewModel();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider<FavoriteService>.value(value: favoriteService),

        ChangeNotifierProvider(create: (context) => themeVM),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => PokemonViewModel()),
        ChangeNotifierProvider(
          create: (context) =>
              FavouriteViewModel(context.read<FavoriteService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeVm = context.watch<ThemeViewModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokeDex Assessment',
      themeMode: themeVm.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      home: AuthWrapper(),
      // initialRoute: AppRouter.home,
    );
  }
}
