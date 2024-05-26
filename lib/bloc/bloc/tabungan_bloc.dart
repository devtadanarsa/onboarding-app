import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:onboarding_app/data/model/tabungan.dart';
import 'package:onboarding_app/data/source/remote_source.dart';

part 'tabungan_event.dart';
part 'tabungan_state.dart';

class TabunganBloc extends Bloc<TabunganEvent, TabunganState> {
  final RemoteDataSource remoteDataSource;
  TabunganBloc({required this.remoteDataSource}) : super(TabunganInitial()) {
    on<LoadTabungan>(_loadTabungan);
  }

  void _loadTabungan(LoadTabungan event, Emitter<TabunganState> emit) async {
    emit(TabunganLoading());
    try {
      final result = await remoteDataSource.getTabungan(event.memberId);
      final saldo = await remoteDataSource.getSaldo(event.memberId);
      final saldoValue = saldo["data"]["saldo"];
      emit(TabunganLoaded(result.data, saldoValue));
    } on DioException catch (error) {
      emit(TabunganError(
        error.response?.statusCode as int,
        error.response?.data,
      ));
    }
  }
}
