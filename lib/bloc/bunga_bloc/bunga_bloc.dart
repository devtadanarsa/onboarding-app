import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onboarding_app/data/model/bunga.dart';
import 'package:onboarding_app/data/source/remote_source.dart';

part 'bunga_event.dart';
part 'bunga_state.dart';

class BungaBloc extends Bloc<BungaEvent, BungaState> {
  final RemoteDataSource remoteDataSource;
  BungaBloc({required this.remoteDataSource}) : super(BungaInitial()) {
    on<LoadBunga>(
      (event, emit) async {
        emit(BungaLoading());
        try {
          final result = await remoteDataSource.getBunga();
          emit(BungaLoaded(result.listBunga, result.activeBunga));
          print("tes mantap");
        } on DioException catch (error) {
          print(error);
          emit(BungaError(error.toString()));
        }
      },
    );
  }
}
