import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_eject/app/common/enum/paywall_plan_type_enum.dart';

class PaywallSelectionCubit extends Cubit<PlanType> {
  PaywallSelectionCubit()
    : super(PlanType.yearly); // default: yearly (daha kârlı)
  void select(PlanType t) => emit(t);
}
