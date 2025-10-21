import 'dart:ui' show VoidCallback;

final class MenuItem {
  const MenuItem({required this.title, required this.routes});

  final String title;
  final List<MenuRoute> routes;
}

final class MenuRoute {
  const MenuRoute({required this.title, this.onPressed});

  final String title;
  final VoidCallback? onPressed;
}
