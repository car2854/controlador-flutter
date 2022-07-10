part of 'user_bloc.dart';

class UserState {
  final UserModel? user;

  const UserState({
    this.user
  });
  
  UserState copyWith({
    UserModel? user
  }) => UserState(
    user: user ?? this.user
  );

  @override
  List<Object?> get props => [ user ];
}
