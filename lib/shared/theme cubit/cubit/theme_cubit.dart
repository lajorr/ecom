import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeStatus(isDark: true));

  Future<void> toggleTheme(bool setDark) async {
    if (setDark) {
      emit(
        const ThemeStatus(isDark: true),
      );
    } else {
      emit(
        const ThemeStatus(isDark: false),
      );
    }
  }
}
