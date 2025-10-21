import 'package:flutter/material.dart';
import 'package:spy_scanner/core/app_sizes.dart';
import 'package:spy_scanner/core/extension/context_theme.dart';
import 'package:spy_scanner/feature/components/menu_card/menu_card_model.dart';
import 'package:spy_scanner/feature/components/separated_column.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({required this.menu, super.key});

  final MenuItem menu;

  @override
  Widget build(BuildContext context) {
    final routes = menu.routes
        .map(
          (e) => ListTile(
            title: Text(
              e.title,
              style: context.textTheme.labelLarge,
            ),

            onTap: e.onPressed,
          ),
        )
        .toList();
    return Column(
      spacing: AppSizes.medium,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.medium),
            child: Text(menu.title, style: context.textTheme.titleSmall),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: SeparatedColumn(
            separator: const Divider(
              height: 0,
            ),
            children: routes,
          ),
        ),
      ],
    );
  }
}
