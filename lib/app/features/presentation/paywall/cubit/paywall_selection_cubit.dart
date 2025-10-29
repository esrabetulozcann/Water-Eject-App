import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/constant/localization_keys.dart';

class PaywallSelectionCubit extends Cubit<String> {
  PaywallSelectionCubit() : super(LocaleKeys.year.tr());

  void selectPackage(String packageType) {
    emit(packageType);
  }
}
