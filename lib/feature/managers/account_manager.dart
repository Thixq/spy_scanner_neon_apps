import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const String _isPremiumKey = 'isPremium';

final class AccountManager {
  AccountManager({required SharedPreferences preferences})
    : _preferences = preferences {
    _currentValue = preferences.getBool(_isPremiumKey) ?? false;
  }

  late bool _currentValue;
  final StreamController<bool> _isPremiumController =
      StreamController<bool>.broadcast();

  Stream<bool> get isPremiumStream async* {
    yield _currentValue;
    yield* _isPremiumController.stream;
  }

  bool get isPremiumSnapshot => _preferences.getBool(_isPremiumKey) ?? false;
  final SharedPreferences _preferences;

  Future<void> addPremium() async {
    final result = await _preferences.setBool(_isPremiumKey, true);
    if (result) _isPremiumController.add(true);
  }

  Future<void> removePremium() async {
    await _preferences.setBool(_isPremiumKey, false);
    _isPremiumController.add(false);
  }
}
