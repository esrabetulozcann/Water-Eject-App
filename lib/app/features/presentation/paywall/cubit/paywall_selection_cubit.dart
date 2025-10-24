import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class PaywallSelectionCubit extends Cubit<String> {
  PaywallSelectionCubit() : super(LocaleKeys.year.tr());

  void selectPackage(String packageType) {
    emit(packageType);
  }
}
