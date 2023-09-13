import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'manage_payment_page.dart';

class ManageMembershipButton extends StatefulWidget {
  const ManageMembershipButton({super.key});

  @override
  State<ManageMembershipButton> createState() => _ManageMembershipButtonState();
}

class _ManageMembershipButtonState extends State<ManageMembershipButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300], // Background color is white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            side: BorderSide(
              color: _isHovering
                  ? const Color(0xffF16523)
                  : Colors.transparent, // Border color on hover
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ManagePaymentPage()),
          );
        },
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
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Manage".toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: " Your Subscription",
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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
