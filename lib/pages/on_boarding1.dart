import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2); // Assuming 3 onboarding pages
              });
            },
            children: const [
              OnboardingContent(
                title: 'Temukan Produk Terbaik',
                description: 'Jelajahi berbagai kategori produk dengan mudah.',
                image:
                    'https://via.placeholder.com/200/FF5733/FFFFFF?text=Onboarding1',
              ),
              OnboardingContent(
                title: 'Belanja Lebih Cepat',
                description: 'Proses checkout yang sederhana dan aman.',
                image:
                    'https://via.placeholder.com/200/33FF57/FFFFFF?text=Onboarding2',
              ),
              OnboardingContent(
                title: 'Pengiriman Terpercaya',
                description: 'Pesanan Anda akan tiba dengan aman di tujuan.',
                image:
                    'https://via.placeholder.com/200/5733FF/FFFFFF?text=Onboarding3',
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(2); // Skip to last page
                  },
                  child: const Text('Skip'),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepPurple,
                  ),
                ),
                isLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text('Get Started'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text('Next'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingContent({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(image, height: 200),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
