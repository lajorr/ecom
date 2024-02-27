part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
}

final class ThemeStatus extends ThemeState {
  const ThemeStatus({required this.isDark});

  final bool isDark;
  @override
  List<Object> get props => [isDark];
}

final class ThemeStoreFailed extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class ThemeFetchSuccess extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class ThemeFetchFailed extends ThemeState {
  @override
  List<Object?> get props => [];
}
