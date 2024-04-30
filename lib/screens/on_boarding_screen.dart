import 'package:flutter/material.dart';
import 'package:shop_app/cachedData/cached_data.dart';
import 'package:shop_app/models/on_boarding.dart';
import 'package:shop_app/screens/login_screeen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardingModel> onBoarding = const [
    OnBoardingModel(
      image: "lib/assets/images/onBoard_1.jpg",
      title: "On Boarding Page 1 title",
      body: "On Boarding Page 1 body",
    ),
    OnBoardingModel(
      image: "lib/assets/images/onBoard_2.jpg",
      title: "On Boarding Page 2 title",
      body: "On Boarding Page 2 body",
    ),
    OnBoardingModel(
      image: "lib/assets/images/onBoard_3.jpg",
      title: "On Boarding Page 3 title",
      body: "On Boarding Page 3 body",
    )
  ];

  final pageController = PageController();
  bool isLast = false;
  void onSubmit() {
    CachedData.putData(
      key: "onBoardingScreen",
      value: true,
    ).then((value) {
      if (value!) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                onSubmit();
              },
              // ignore: prefer_const_constructors
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: const Text(
                  "SKIP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == onBoarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: pageController,
                  itemCount: onBoarding.length,
                  itemBuilder: (context, index) => onBoardingItem(
                    onBoarding[index],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 18,
                      expansionFactor: 4,
                      activeDotColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    controller: pageController,
                    count: onBoarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onPressed: () {
                      if (isLast) {
                        onSubmit();
                      }
                      pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    },
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

Widget onBoardingItem(OnBoardingModel onBoarding) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(onBoarding.image),
        ),
        const SizedBox(height: 20),
        Text(
          onBoarding.title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          onBoarding.body,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
