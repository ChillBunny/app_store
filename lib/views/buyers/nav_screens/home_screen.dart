import 'package:app_store/views/buyers/nav_screens/widgets/banner_widgets.dart';
import 'package:app_store/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:app_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:app_store/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WelcomeText(),
        const SizedBox(
          height: 14,
        ),
        const SearchInputWidget(),
        const BannerWidget(),
        CategoryText(),
      ],
    );
  }
}
