import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyElevatedButton extends StatefulWidget {
  final String firstText;
  final String secondText;
  final String thirdText;
  final VoidCallback onPress;

  const MyElevatedButton(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.thirdText, required this.onPress});

  @override
  _MyElevatedButtonState createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Background color is white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            side: BorderSide(
              color: _isHovering
                  ? const Color(0xffF16523)
                  : Colors.transparent, // Border color on hover
            ),
          ),
        ),
        onPressed: widget.onPress,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.7, // 70% of screen size
            padding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 15), // Padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: _isHovering ? Color(0xffF16523) : Colors.transparent,
                    size: 14,
                  ),
                ),

                const SizedBox(width: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.firstText.toUpperCase(),
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " ${widget.secondText}  ",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: widget.thirdText,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ), // Subtitle
              ],
            ),
          ),
        ),
      ),
    );
  }
}
