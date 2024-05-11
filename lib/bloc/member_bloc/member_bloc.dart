import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/data/source/remote_source.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final RemoteDataSource remoteDataSource;

  MemberBloc({required this.remoteDataSource}) : super(MemberInitial()) {
    on<LoadMember>(_loadMember);
    on<AddMember>(_addMember);
  }

  void _loadMember(LoadMember event, Emitter<MemberState> emit) async {
    emit(MemberLoading());
    try {
      final result = await remoteDataSource.getMembers();
      emit(MemberLoaded(result.data));
    } catch (error) {
      emit(MemberError(error.toString()));
    }
  }

  void _addMember(AddMember event, Emitter<MemberState> emit) async {
    try {
      await remoteDataSource.addMember(event.member);
    } catch (error) {
      emit(MemberError(error.toString()));
    }
  }
}
