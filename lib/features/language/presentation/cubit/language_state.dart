part of 'language_cubit.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();
}

final class LanguageCurrent extends LanguageState {
  const LanguageCurrent({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}
