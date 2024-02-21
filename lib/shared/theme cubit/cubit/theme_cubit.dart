import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeModeLight(isDark: false));

  Future<void> toggleTheme(bool setDark) async {
    if (setDark) {
      emit(
        const ThemeModeDark(isDark: true),
      );
    } else {
      emit(
        const ThemeModeLight(isDark: false),
      );
    }
  }
}
