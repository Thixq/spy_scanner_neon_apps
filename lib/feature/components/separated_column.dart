import 'package:flutter/material.dart';

class SeparatedColumn extends StatelessWidget {
  const SeparatedColumn({
    required this.children,
    required this.separator,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });
  final List<Widget> children;
  final Widget separator;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  // Çocuk ve ayırıcıları içeren yeni bir liste oluşturur.
  List<Widget> _buildSeparatedList() {
    if (children.isEmpty) {
      return [];
    }

    // İlk öğeyi al
    final items = <Widget>[children.first];

    // Kalan öğeleri ve her birinden önce ayırıcıyı ekle
    for (var i = 1; i < children.length; i++) {
      items.add(separator);
      items.add(children[i]);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // Column widget'ını kullanarak ayrılmış listeyi render et.
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _buildSeparatedList(),
    );
  }
}
