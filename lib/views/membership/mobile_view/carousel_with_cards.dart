import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'list_mobile_membership_cards.dart';

class CarouselWithCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of cards
    const List<Widget> cards = memberShipCards;

    return Center(
      child: CarouselSlider(
        items: cards,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.5,
          viewportFraction: 0.75,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
