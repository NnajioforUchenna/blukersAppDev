import 'package:flutter/material.dart';

class OptionBox extends StatefulWidget {
  final String imgSrc;
  final String title;
  final Function onTap;
  final Color color;
  final String subtitle;
  final String thirdLine;
  const OptionBox(
      {super.key,
      required this.imgSrc,
      required this.title,
      required this.onTap,
      required this.color,
      required this.subtitle,
      required this.thirdLine});

  @override
  State<OptionBox> createState() => _OptionBoxState();
}

class _OptionBoxState extends State<OptionBox> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // hide splash color
      splashColor: Colors.transparent,
      // hide highlight color
      highlightColor: Colors.transparent,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),

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
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: _isHovering
                ? const BorderSide(color: Colors.white, width: 2.0)
                : BorderSide.none,
          ),
          child: Container(
            color: widget.color,
            width: MediaQuery.of(context).size.height * 0.2,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    widget.thirdLine,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}