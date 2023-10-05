import 'package:flutter/material.dart';

class RenderTextItems extends StatelessWidget {
  final List itemsList;

  const RenderTextItems({
    Key? key,
    required this.itemsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: itemsList.map<Widget>((category) => Text(category)).toList(),
    );
  }
}
