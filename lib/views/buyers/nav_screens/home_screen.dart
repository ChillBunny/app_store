import 'package:app_store/views/buyers/nav_screens/widgets/banner_widgets.dart';
import 'package:app_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:app_store/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 25, right: 15),
        child: const Column(
          children: [
            WelcomeText(),
            SizedBox(
              height: 14,
            ),
            SearchInputWidget(),
            BannerWidget(),
          ],
      )
    );
  }
}
