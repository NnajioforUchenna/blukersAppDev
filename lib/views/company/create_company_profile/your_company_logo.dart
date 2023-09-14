import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/company_provider.dart';

class YourCompanyLogo extends StatelessWidget {
  const YourCompanyLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    String? logoUrl = cp.appUser
        ?.photoUrl; // Change to the appropriate property for the company logo URL
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  cp.selectCompanyLogo(
                      context); // Change to the appropriate method for selecting the company logo
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: logoUrl == null || logoUrl.isEmpty
                        ? const Center(
                            child: Text(
                              'Tap to select a logo',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: logoUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
