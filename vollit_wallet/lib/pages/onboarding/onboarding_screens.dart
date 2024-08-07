import 'package:flutter/material.dart';
import 'package:vollit_wallet/l10n/app_localizations.dart';
import 'package:vollit_wallet/main.dart';
import 'package:vollit_wallet/utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Onboard> demoData = [
      Onboard(
        image: 'assets/images/onboard1.png',
        title:"Send crypto securely",
        // title: AppLocalizations.of(context)!
        //     .helloWorld, // Updated for localization
        description: 'Secure way of sending and receiving cryptocurrency',
      ),
      Onboard(
        image: 'assets/images/onboard2.png',
        title: 'View Your NFTs and Assets',
        description: 'View your NFTs and digital assets securely',
      ),
      Onboard(
        image: 'assets/images/onboard3.png',
        title: 'Send Crypto Safely',
        description:
            'With us, you don\'t need to worry about any security-related issues.',
      ),
    ];

    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: demoData[index].image,
                    title: demoData[index].title,
                    description: demoData[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex == demoData.length - 1) {
                          // Navigate to the next screen when reaching the last page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: buttonColor,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.yellow : Colors.yellow.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String image;
  final String title;
  final String description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnBoardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 28, color: buttonColor),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 133, 133, 132)),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
