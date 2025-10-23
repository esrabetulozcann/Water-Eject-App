import 'package:shared_preferences/shared_preferences.dart';

class PremiumService {
  static const String _isPremiumKey = 'isPremium';

  Future<bool> get isPremium async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPremiumKey) ?? false;
  }

  Future<void> activatePremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, true);
  }

  Future<void> resetPremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, false);
  }
}
