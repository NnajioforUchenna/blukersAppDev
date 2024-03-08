import 'package:flutter/material.dart';

import '../../../../../services/responsive.dart';

import 'new_mobile_view/new_mobile_products_widget.dart';
import 'web_view/desktop_products_widget.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const NewMobileProductsWidget()
        : const DesktopProductsWidget();
  }
}
