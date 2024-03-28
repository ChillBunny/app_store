import 'package:app_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Howdy, What Are You\n Looking For',
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: 'Semi-Bold')),
        Container(
          child: SvgPicture.asset(
            'assets/icons/cart.svg',
            width: 20,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
