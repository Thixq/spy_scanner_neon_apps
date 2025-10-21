import 'package:flutter/material.dart';
import 'package:spy_scanner/feature/components/menu_card/menu_card.dart';
import 'package:spy_scanner/feature/components/menu_card/menu_card_model.dart';

class MenuCardViewer extends StatelessWidget {
  const MenuCardViewer({
    required this.menuItems,
    required this.separatorBuilder,
    super.key,
  });

  final List<MenuItem> menuItems;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final menuItem = menuItems[index];
        return MenuCard(menu: menuItem);
      },
      separatorBuilder: separatorBuilder,
      itemCount: menuItems.length,
    );
  }
}
