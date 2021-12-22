import 'package:excercise_stocks/common/home_page.dart';
import 'package:excercise_stocks/common/loader_widget.dart';
import 'package:excercise_stocks/feature/authentication/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),
          alignment: Alignment.center,
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return state is AuthenticationLoading
                  ? LoaderWidget()
                  : ElevatedButton.icon(
                      label: Text('Sign in with Google'),
                      icon: FaIcon(FontAwesomeIcons.google),
                      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                      onPressed: () => BlocProvider.of<AuthenticationCubit>(context).signIn(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
