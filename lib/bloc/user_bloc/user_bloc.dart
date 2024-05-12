import 'package:flutter/material.dart';
import 'package:onboarding_app/data/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/data/source/remote_source.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RemoteDataSource remoteDataSource;
  UserBloc({required this.remoteDataSource}) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      print("Load User");
      emit(UserLoading());
      try {
        final result = await remoteDataSource.getUser();
        emit(UserLoaded(result));
      } catch (error) {
        emit(UserError(error.toString()));
      }
    });

    on<InitUser>((event, emit) {
      print("Initial State");
      emit(UserInitial());
    });
  }
}
