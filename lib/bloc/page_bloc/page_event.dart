part of 'page_bloc.dart';

@immutable
sealed class PageEvent {}

final class SwitchPage extends PageEvent {
  final int pageIdx;

  SwitchPage(this.pageIdx);
}
