import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'flip_card.dart';
import 'list_mobile_membership_cards.dart';

class CarouselWithCards extends StatefulWidget {
  @override
  State<CarouselWithCards> createState() => _CarouselWithCardsState();
}

class _CarouselWithCardsState extends State<CarouselWithCards> {
  List<List<Widget>> combineLists(List<Widget> list1, List<Widget> list2) {
    return List<List<Widget>>.generate(
        list1.length, (index) => [list1[index], list2[index]]);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List of cards

    List<List<Widget>> combinedList =
        combineLists(memberShipCards, backMemberShipCards);

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
