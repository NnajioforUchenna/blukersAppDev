import 'package:blukers/data_providers/country_state_city_provider.dart';
import 'package:blukers/providers/create_worker_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WorkExperienceLocationForm extends StatefulWidget {
  final int intialIndex;

  const WorkExperienceLocationForm({super.key, required this.intialIndex});

  @override
  State<WorkExperienceLocationForm> createState() =>
      _WorkExperienceLocationFormState();
}

class _WorkExperienceLocationFormState
    extends State<WorkExperienceLocationForm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        CountryStateCityProvider cscp =
            Provider.of<CountryStateCityProvider>(context, listen: false);
        cscp.getCountries(widget.intialIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CreateWorkerProfileProvider wp =
        Provider.of<CreateWorkerProfileProvider>(context);
    CountryStateCityProvider cscp =
        Provider.of<CountryStateCityProvider>(context);

    return Row(
      children: [
        // Country Dropdown
        Expanded(
          child: DropdownButtonFormField<String>(
            value: wp.workExperience[widget.intialIndex]['country'],
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                wp.workExperience[widget.intialIndex]['country'] = value!;
                cscp.setSelectedCountry(widget.intialIndex, value);
                cscp.getStates(widget.intialIndex, value);
                wp.workExperience[widget.intialIndex]['state'] = null;
                wp.workExperience[widget.intialIndex]['city'] = null;
              });
            },
            validator: (value) =>
                value == null ? AppLocalizations.of(context)!.required : null,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.country,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.black,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            items: cscp.countries[widget.intialIndex]
                    ?.map((country) => DropdownMenuItem<String>(
                          value: country.isoCode,
                          child: Text(
                            country.name,
                            overflow: TextOverflow
                                .ellipsis, // Truncate text with ellipsis
                            maxLines: 1,
                          ),
                        ))
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(width: 10),
        // State Dropdown
        Expanded(
          child: DropdownButtonFormField<String>(
            value: wp.workExperience[widget.intialIndex]['state'],
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                wp.workExperience[widget.intialIndex]['state'] = value!;
                cscp.setSelectedState(widget.intialIndex, value);
                cscp.getCities(
                    widget.intialIndex,
                    cscp.selectedCountry[widget.intialIndex]!,
                    cscp.states[widget.intialIndex]!
                        .firstWhere((state) => state.name == value)
                        .isoCode);
                wp.workExperience[widget.intialIndex]['city'] = null;
              });
            },
            validator: (value) =>
                value == null ? AppLocalizations.of(context)!.required : null,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.state,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.black,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            items: cscp.states[widget.intialIndex]
                    ?.map((state) => DropdownMenuItem<String>(
                          value: state.name,
                          child: Text(state.name,
                              overflow: TextOverflow
                                  .ellipsis, // Truncate text with ellipsis
                              maxLines: 1),
                        ))
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(width: 10),
        // City Dropdown
        Expanded(
          child: DropdownButtonFormField<String>(
            value: wp.workExperience[widget.intialIndex]['city'],
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                wp.workExperience[widget.intialIndex]['city'] = value!;
                cscp.setSelectedCity(widget.intialIndex, value);
              });
            },
            validator: (value) =>
                value == null ? AppLocalizations.of(context)!.required : null,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.city,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.black,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            items: cscp.cities[widget.intialIndex]
                    ?.map((city) => DropdownMenuItem<String>(
                          value: city.name,
                          child: Text(city.name,
                              overflow: TextOverflow
                                  .ellipsis, // Truncate text with ellipsis
                              maxLines: 1),
                        ))
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
