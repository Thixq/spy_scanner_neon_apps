import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/components/menu_card/menu_card_model.dart';
import 'package:spy_scanner/feature/components/menu_card/menu_card_viewer.dart';
import 'package:spy_scanner/feature/components/profile_card.dart';

@RoutePage()
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: AppSizes.extraLarge,
          children: [
            const ProfileCard(),
            Flexible(
              child: MenuCardViewer(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSizes.large),
                menuItems: [
                  MenuItem(
                    title: 'Genel',
                    routes: [
                      MenuRoute(
                        title: 'Gizlilik',
                        onPressed: () {},
                      ),
                      MenuRoute(
                        title: 'Güvenlik',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  MenuItem(
                    title: 'Profile',
                    routes: [
                      MenuRoute(
                        title: 'Şifre değiştir',
                        onPressed: () {},
                      ),
                      MenuRoute(
                        title: 'Çıkış yap',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
