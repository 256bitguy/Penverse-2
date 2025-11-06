import 'dart:async';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  final List<String> _images = [
    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761832365/uploads/urhas9m3ocuikypkxisj.png",
    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761831450/uploads/goyzdyfi4ozml1e8oulr.png",
    "https://res.cloudinary.com/dmxskf3hq/image/upload/v1761831484/uploads/ihxsh3prx7hy3yfdsgqn.png",
  ];

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_controller.hasClients) {
        _currentPage = (_currentPage + 1) % _images.length;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  return SizedBox(
    width: double.infinity,
    height: screenSize.height * 0.4,
    child: PageView.builder(
      controller: _controller,
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blueAccent, // border color
              width: 3, // border width
            ),
              boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
    ),
  );
}

}
