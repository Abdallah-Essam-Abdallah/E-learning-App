import 'package:equatable/equatable.dart';

class AuthinticationRequestEntity extends Equatable {
  final String token;

  const AuthinticationRequestEntity({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}
