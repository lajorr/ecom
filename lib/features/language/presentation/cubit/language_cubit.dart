import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageCurrent(index: 1));

  void onSetCurrentLanguage(int index) {
    emit(LanguageCurrent(index: index));
  }
}
