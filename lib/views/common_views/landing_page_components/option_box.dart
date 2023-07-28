import 'package:flutter/material.dart';
import '../../../../utils/styles/index.dart';

class OptionBox extends StatefulWidget {
  final String imgSrc;
  final String title;
  final Function onTap;
  const OptionBox(
      {super.key,
      required this.imgSrc,
      required this.title,
      required this.onTap});

  @override
  State<OptionBox> createState() => _OptionBoxState();
}

class _OptionBoxState extends State<OptionBox> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (_) {
          // Handle hover enter
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (_) {
          // Handle hover exit
          setState(() {
            _isHovering = false;
          });
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: _isHovering
                ? BorderSide(color: ThemeColors.primaryThemeColor, width: 2.0)
                : BorderSide.none,
          ),
          child: Container(
            width: MediaQuery.of(context).size.height * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    widget.imgSrc,
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: ThemeTextStyles.landingPageBtnThemeTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
