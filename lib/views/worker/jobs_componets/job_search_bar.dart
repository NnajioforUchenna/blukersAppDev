import 'package:bulkers/utils/styles/index.dart';
import 'package:flutter/material.dart';

class JobSearchBar extends StatefulWidget {
  @override
  _JobSearchBarState createState() => _JobSearchBarState();
}

class _JobSearchBarState extends State<JobSearchBar> {
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _searchController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.primaryThemeColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First search field
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.28,
                child: TextField(
                  controller: _searchController1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Position, work area or company',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _searchController1.text.isEmpty
                          ? null
                          : () => _searchController1.clear(),
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              // Second search field
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.28,
                child: TextField(
                  controller: _searchController2,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'colony, city or state',
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _searchController2.text.isEmpty
                          ? null
                          : () => _searchController2.clear(),
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              // Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    // Action for the button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ThemeColors.secondaryThemeColor, // Red color
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'To Look For A Job',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }
}