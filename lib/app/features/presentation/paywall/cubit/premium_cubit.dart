import 'package:bloc/bloc.dart';
import 'package:water_eject/app/domain/services/premium_service.dart';

class PremiumCubit extends Cubit<bool> {
  final PremiumService _premiumService;

  PremiumCubit(this._premiumService) : super(false);

  Future<void> checkPremiumStatus() async {
    final isPremium = await _premiumService.isPremium;
    emit(isPremium);
  }

  Future<void> activatePremium() async {
    await _premiumService.activatePremium();
    emit(true);
  }

  // Test için
  Future<void> resetPremium() async {
    await _premiumService.resetPremium();
    emit(false);
  }
}
