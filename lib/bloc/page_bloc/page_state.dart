part of 'page_bloc.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {}

final class CurrentPage extends PageState {
  final int currentPage;
  CurrentPage(this.currentPage);
}
