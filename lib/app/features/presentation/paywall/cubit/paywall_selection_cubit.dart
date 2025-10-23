import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class PaywallSelectionCubit extends Cubit<String> {
  PaywallSelectionCubit() : super('year'.tr());

  void selectPackage(String packageType) {
    emit(packageType);
  }
}
