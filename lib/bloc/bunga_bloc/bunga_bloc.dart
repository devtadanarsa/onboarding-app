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
    on<LoadBunga>(_loadBunga);
    on<AddBunga>(_addBunga);
  }

  void _loadBunga(LoadBunga event, Emitter<BungaState> emit) async {
    emit(BungaLoading());
    try {
      final result = await remoteDataSource.getBunga();
      if (result == null) {
        emit(BungaLoaded(const [], Bunga(id: 1, persen: 0, isActive: 0)));
      } else {
        emit(BungaLoaded(result.listBunga, result.activeBunga));
      }
    } on DioException catch (error) {
      emit(BungaError(
        error.response?.statusCode as int,
        error.response?.data,
      ));
    }
  }

  void _addBunga(AddBunga event, Emitter<BungaState> emit) async {
    emit(BungaLoading());
    try {
      await remoteDataSource.addBunga(event.bunga);
      emit(BungaAdded());
    } on DioException catch (error) {
      emit(BungaError(
        error.response?.statusCode as int,
        error.response?.data,
      ));
    }
  }
}
