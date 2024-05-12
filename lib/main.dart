import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/bloc/user_bloc/user_bloc.dart';
import 'package:onboarding_app/data/source/remote_source.dart';
import 'package:onboarding_app/presentation/screens/home/login_page.dart';
import 'package:onboarding_app/presentation/screens/main/main_layout.dart';
import 'package:onboarding_app/presentation/screens/home/otp_page.dart';
import 'package:onboarding_app/presentation/screens/home/register_page.dart';
import 'package:onboarding_app/presentation/screens/home/welcome_page.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(remoteDataSource: RemoteDataSource()),
        ),
        BlocProvider<MemberBloc>(
          create: (context) => MemberBloc(remoteDataSource: RemoteDataSource()),
        ),
      ],
      child: MaterialApp(
        theme: _buildTheme(Brightness.light),
        routes: {
          "/": (context) => const WelcomePage(),
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/otp": (context) => const OTPPage(),
          "/home": (context) => const MainLayout(),
        },
        initialRoute: "/home",
      ),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
    );
  }
}
