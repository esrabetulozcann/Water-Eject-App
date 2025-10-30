import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/features/presentation/setting/cubit/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  //  başlangıç değerleri dışarıdan aldım
  SettingCubit({required bool isDark, required bool isEnglish})
    : super(SettingState(isDarkMode: isDark, isEnglish: isEnglish));

  void toggleDarkMode(bool value) {
    emit(state.copyWith(isDarkMode: value));
  }

  void toggleLanguage(bool isEnglish) {
    emit(state.copyWith(isEnglish: isEnglish));
  }
}
