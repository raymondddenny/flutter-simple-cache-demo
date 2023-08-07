import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caching_demo_app/injector_container.dart';
import 'package:flutter_caching_demo_app/simple_cache/presentation/bloc/cubit/all_character_cubit.dart';
import 'package:flutter_caching_demo_app/simple_cache/presentation/pages/all_character_page.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AllCharacterCubit>()..getAllCharacters()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AllCharactedPage(),
      ),
    );
  }
}
