import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medium_app/pages/lognPage.dart';
import 'package:medium_app/pages/welcomePage.dart';

class TestOnboard extends StatefulWidget {
  @override
  _TestOnboardState createState() => _TestOnboardState();
}

class _TestOnboardState extends State<TestOnboard> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WelcomePage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0,fontFamily: 'Josefin Sans');
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700,fontFamily: 'Josefin Sans'),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [

        PageViewModel(
          title: "Learn as you go",
          body:
          "Gat all Nigeria tech news at your fingertip"
              " from reliable sources",
          image: _buildImage('thirdimg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "For everyone",
          body:
          "You don't have to be a tech geek, you can leverage"
              " from ocean of ideas to get started ",
          image: _buildImage('ideaboi'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: " Your Ideas counts ",
          body: "We don't just feed you with news;"
              "you are free to add yours",
          image: _buildImage('readingbook'),
          footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip',style: TextStyle(fontFamily: 'Josefin Sans'),),
      next: const Icon(FeatherIcons.arrowRight),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}