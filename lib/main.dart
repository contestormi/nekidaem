import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekidaem/presentation/auth_screen/auth_bloc/authentication_bloc.dart';
import 'package:nekidaem/presentation/auth_screen/auth_screen.dart';
import 'package:nekidaem/presentation/kanban_screen/kanban_bloc/kanban_bloc.dart';
import 'package:nekidaem/presentation/kanban_screen/kanban_screen.dart';
import 'package:nekidaem/services/cache_serivce.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.initHive();
  await EasyLocalization.ensureInitialized();
  bool loggedIn = CacheService.tokenBox.containsKey('key');
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(
        loggedIn: loggedIn,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.loggedIn}) : super(key: key);
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(),
          ),
          BlocProvider(
            create: (context) => KanbanBloc(),
          ),
        ],
        child: loggedIn ? const KanbanScreen() : const AuthScreen(),
      ),
    );
  }
}
