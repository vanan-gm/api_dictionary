import 'package:api_dictionary/blocs/word_bloc/word_bloc.dart';
import 'package:api_dictionary/commons/app_preferences.dart';
import 'package:api_dictionary/injector.dart';
import 'package:api_dictionary/presentation/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setUpInjector();
  await AppPreferences.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<WordBloc>(
              create: (_) => getIt<WordBloc>(),
            )
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-E Dictionary',
            home: HomePage(),
          ),
        );
      }
    );
  }
}

