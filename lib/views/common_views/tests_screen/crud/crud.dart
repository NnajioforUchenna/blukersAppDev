import 'package:flutter/material.dart';
import 'products/index.dart';

class CRUD extends StatefulWidget {
  const CRUD({super.key});

  @override
  State<CRUD> createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  @override
  Widget build(BuildContext context) {
    return buildCRUDModules(context);
  }

  Widget buildCRUDModules(context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 80),
          //
          ProductCreate(),
          SizedBox(height: 2),
          ProductReadAll(),
          SizedBox(height: 40),
          //
          ProductCategoryCreate(),
          SizedBox(height: 2),
          ProductCategoryReadAll(),
          SizedBox(height: 40),
          //
          ProductSubcategoryCreate(),
          SizedBox(height: 2),
          ProductSubcategoryReadAll(),
          SizedBox(height: 40),
          //
          ProductStatusCreate(),
          SizedBox(height: 2),
          ProductStatusReadAll(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}