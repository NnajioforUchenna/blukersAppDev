import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common_files/constants.dart';
import '../../../../providers/payment_providers/payments_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';
import 'flip_card.dart';
import 'list_mobile_membership_cards.dart';
import 'my_evelated_button.dart';

class CarouselWithCards extends StatefulWidget {
  @override
  State<CarouselWithCards> createState() => _CarouselWithCardsState();
}

class _CarouselWithCardsState extends State<CarouselWithCards> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List of cards

    List<List<Widget>> combinedList =
        combineLists(memberShipCards, backMemberShipCards);
    PaymentsProvider pp = Provider.of<PaymentsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);

    return Center(
        child: CarouselSlider(
      items: combinedList.asMap().entries.map((entry) {
        int index = entry.key;
        var pair = entry.value;
        return Column(
          children: [
            FlipCard(
              front: pair[0],
              back: pair[1],
              shouldFlip: _currentIndex == index, // Flip only the current card
            ),
            const SizedBox(
              height: 40,
            ),
            if (up.appUser == null || !up.appUser!.isSubscriptionActive)
              MyElevatedButton(
                firstText: membershipButtonsMap[index]!['firstText'],
                secondText: membershipButtonsMap[index]!['secondText'],
                thirdText: membershipButtonsMap[index]!['thirdText'],
                onPress: () async {
                  pp.pay4Subscription(
                    context,
                    membershipButtonsMap[index]!['onPress'],
                  );
                },
              )
          ],
        );
      }).toList(),
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index; // update the current index
          });
        },
        height: MediaQuery.of(context).size.height * 0.85,
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
