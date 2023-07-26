import 'package:flutter/material.dart';

class OptionBox extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const OptionBox(
      {super.key,
      required this.icon,
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
                ? BorderSide(color: Colors.pink, width: 2.0)
                : BorderSide.none,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 50,
                  ),
                  Text(widget.title),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
