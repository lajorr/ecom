import 'package:bloc/bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../domain/usecase/fetch_theme_status_usecase.dart';
import '../../../domain/usecase/store_theme_status_usecase.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required this.storeThemeStatusUsecase,
    required this.fetchThemeStatusUsecase,
  }) : super(const ThemeStatus(isDark: true));

  final StoreThemeStatusUsecase storeThemeStatusUsecase;
  final FetchThemeStatusUsecase fetchThemeStatusUsecase;

  Future<void> toggleTheme(bool setDark) async {
    final storeOrFail = await storeThemeStatusUsecase.call(setDark);
    storeOrFail.fold((failure) => emit(ThemeStoreFailed()), (_) {
      if (setDark) {
        emit(
          const ThemeStatus(isDark: true),
        );
      } else {
        emit(
          const ThemeStatus(isDark: false),
        );
      }
    });
  }

  Future<void> getThemeStatus() async {
    final statusOrFail = await fetchThemeStatusUsecase.call(NoParams());
    statusOrFail.fold((failure) => emit(ThemeFetchFailed()), (status) {
      emit(
        ThemeStatus(isDark: status),
      );
    });
  }
}
