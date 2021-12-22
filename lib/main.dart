import 'package:excercise_stocks/common/home_page.dart';
import 'package:excercise_stocks/feature/authentication/cubit/authentication_cubit.dart';
import 'package:excercise_stocks/feature/authentication/ui/page/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()..checkUser()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(builder: (context, state) {
        if (state is Authenticated) {
          return HomePage();
        } else {
          return SignInPage();
        }
      }),
    );
  }
}
