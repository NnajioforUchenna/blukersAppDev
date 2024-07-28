import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/company_provider.dart';

class YourCompanyLogo extends StatelessWidget {
  const YourCompanyLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    String? logoUrl = cp.appUser
        ?.photoUrl; // Change to the appropriate property for the company logo URL
    return Card(
      elevation: 1.0,
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
                  cp.selectCompanyLogo(context);
                },
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: logoUrl == null || logoUrl.isEmpty
                        ? Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!
                                  .tapToSelectAndUploadAFile,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Montserrat",
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
