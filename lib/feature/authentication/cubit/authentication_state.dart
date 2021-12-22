part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class SignInSuccess extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User user;
  final String token;

  Authenticated(this.user, this.token);

  @override
  List<Object> get props => [this.user, this.token];
}

class AuthenticatedFailure extends AuthenticationState {
  final String error;

  AuthenticatedFailure({this.error});

  @override
  List<Object> get props => [this.error];
}
