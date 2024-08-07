import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<SwitchPage>((event, emit) {
      emit(CurrentPage(event.pageIdx));
    });

    on<InitPage>((event, emit) {
      emit(PageInitial());
    });
  }
}
