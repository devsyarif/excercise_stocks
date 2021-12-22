import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  checkUser() async {
    emit(AuthenticationLoading());
    print('_auth.currentUser ${_auth.currentUser}');
    if (_auth.currentUser == null) {
      emit(UnAuthenticated());
    } else {
      String token = await _auth.currentUser.getIdToken();
      emit(Authenticated(_auth.currentUser, token));
    }
  }

  signIn() async {
    try {
      emit(AuthenticationLoading());
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthenticatedFailure());
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      String token = await _auth.currentUser.getIdToken();
      emit(Authenticated(_auth.currentUser, token));
    } catch (e) {
      emit(AuthenticatedFailure(error: '$e'));
    }
  }

  logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      emit(UnAuthenticated());
    } catch (e) {
      print(e);
    }
  }
}
