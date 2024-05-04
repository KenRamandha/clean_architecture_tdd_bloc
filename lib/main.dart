import 'package:clean_rchitecture_tdd_bloc/core/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/persentation/cubit/authentification_cubit.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/persentation/views/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthentificationCubit>(),
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const HomeScreen(),
      ),
    );
  }
}
