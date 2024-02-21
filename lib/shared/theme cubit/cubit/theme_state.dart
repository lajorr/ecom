part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeModeDark extends ThemeState {
  const ThemeModeDark({required this.isDark});

  final bool isDark;
}

final class ThemeModeLight extends ThemeState {
  const ThemeModeLight({required this.isDark});

  final bool isDark;
}
