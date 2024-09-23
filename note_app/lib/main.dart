import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
import 'package:note_app/presentation/bloc/note_bloc.dart';
import 'package:note_app/presentation/screens/home/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: NavigationService.instance.navigationKey,
        theme: ThemeData(
          scaffoldBackgroundColor: whitecolor,
          appBarTheme: const AppBarTheme(
              backgroundColor: whitecolor, surfaceTintColor: whitecolor),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ScreenHome(),
      ),
    );
  }
}
