part of 'settings_view.dart';

mixin _SettingsMixin on State<SettingsView> {
  late final ProfileManager _profileManager;

  @override
  void initState() {
    _profileManager = DependencyInstances.manager.profile;
    super.initState();
  }
}
