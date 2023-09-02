import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../common_files/constants.dart';
import '../../membership/mobile_view/flip_card.dart';
import 'list_mobile_service_cards.dart';

class ServicesCarouselCards extends StatefulWidget {
  const ServicesCarouselCards({super.key});

  @override
  State<ServicesCarouselCards> createState() => _ServicesCarouselCardsState();
}

class _ServicesCarouselCardsState extends State<ServicesCarouselCards> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List of cards

    List<List<Widget>> combinedList =
        combineLists(servicesCards, backServicesCards);

    return Center(
        child: CarouselSlider(
      items: combinedList.asMap().entries.map((entry) {
        int index = entry.key;
        var pair = entry.value;
        return FlipCard(
          front: pair[0],
          back: pair[1],
          shouldFlip: _currentIndex == index, // Flip only the current card
        );
      }).toList(),
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index; // update the current index
          });
        },
        height: MediaQuery.of(context).size.height * 0.5,
        viewportFraction: 0.75,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(
            seconds:
                7), // Change to 10 since you're flipping the card every 5 seconds
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    ));
  }
}
