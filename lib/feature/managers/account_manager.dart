import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const String _isPremiumKey = 'isPremium';

final class AccountManager {
  AccountManager({required SharedPreferences preferences})
    : _preferences = preferences {
    _isPremiumController.add(preferences.getBool(_isPremiumKey) ?? false);
  }

  final StreamController<bool> _isPremiumController =
      StreamController<bool>.broadcast();

  Stream<bool> get isPremiumStream => _isPremiumController.stream;
  bool get isPremiumSnapshot => _preferences.getBool(_isPremiumKey) ?? false;
  final SharedPreferences _preferences;

  Future<void> addPremium() async {
    await _preferences.setBool(_isPremiumKey, true);
    _isPremiumController.add(true);
  }

  Future<void> removePremium() async {
    await _preferences.setBool(_isPremiumKey, false);
    _isPremiumController.add(false);
  }
}
