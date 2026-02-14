import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Login.dart';

// ************************
// الألوان والثوابت
// ************************
const Color kPrimaryColor = Color(0xffA5B5C1);
const Color kWhiteColor = Colors.white;
const Color kTextColor = Colors.black87;

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // مؤشر الصفحات
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 3,
      width: _currentPage == index ? 60 : 25,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? kTextColor
            : kTextColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  // محتوى الصفحة
  Widget _buildPageContent({
    required String title,
    required String description,
    required String imagePath,
    required int pageIndex,
  }) {
    VoidCallback onNextPressed;
    if (pageIndex < _numPages - 1) {
      onNextPressed = () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      };
    } else {
      onNextPressed = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      };
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 الشعار في الأعلى
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              "assets/images/Group 16204.svg",
              height: 60,
            ),
          ),

          // 🔹 الصورة والنصوص (في المنتصف عموديًا)
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kTextColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "gilroy",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kTextColor,
                      fontSize: 15,
                      height: 1.4,
                      fontFamily: "gilroy pro",
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 المؤشر والأزرار في الأسفل
          Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_numPages, (index) => _buildDot(index)),
              ),
              const SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر Skip
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    child: const Text(
                      "Skip step",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: "gilroy",
                      ),
                    ),
                  ),
                  // زر Next / Get Started
                  InkWell(
                    onTap: onNextPressed,
                    child: Container(
                      width: 120,
                      height: 44,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        pageIndex < _numPages - 1 ? "Next" : "Get Started",
                        style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: 16,
                          fontFamily: "gilroy",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // بناء واجهة الـ Onboarding
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          _buildPageContent(
            title: "Welcome to Kleine",
            description:
                "Wherever you are, we create creativity for you!\nExplore the best care products for your skin,\nhair, and body, and make your daily routine easier and more enjoyable.",
            imagePath: "assets/images/reading.svg",
            pageIndex: 0,
          ),
          _buildPageContent(
            title: "Your Care, Your Way",
            description:
                "Personalized solutions for your skin, hair, and body.\nBecause you deserve the best every day.",
            imagePath: "assets/images/reading.svg",
            pageIndex: 1,
          ),
        ],
      ),
    );
  }
}
