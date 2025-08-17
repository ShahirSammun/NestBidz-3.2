import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';
import '../widget/appDrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const List<Map<String, String>> featuredProperties = [
    {
      'image': 'assets/images/pic11.jpg',
      'price': '\$3000',
      'details': '2 Bed • 2 Bath',
    },
    {
      'image': 'assets/images/pic2.jpg',
      'price': '\$2500',
      'details': '3 Bed • 2 Bath',
    },
    {
      'image': 'assets/images/pic3.jpg',
      'price': '\$4000',
      'details': '4 Bed • 3 Bath',
    },
  ];

  static const List<Map<String, String>> categories = [
    {'image': 'assets/images/villa.png', 'title': 'Villa'},
    {'image': 'assets/images/flat.png', 'title': 'Apartment'},
    {'image': 'assets/images/plot.png', 'title': 'Plot'},
    {'image': 'assets/images/mess.png', 'title': 'Mess'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) => ScreenBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// App Bar Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      const Text(
                        "NESTBIDZ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 50),

                  /// Search Bar
                  Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "What are you looking for?",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// Categories Title
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// Categories Row (Evenly spaced)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories
                        .map((cat) =>
                        _categoryItem(cat['image']!, cat['title']!))
                        .toList(),
                  ),
                  const SizedBox(height: 22),

                  /// Featured Properties Header
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Properties",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Featured Properties Slider
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredProperties.length,
                      itemBuilder: (context, index) {
                        final property = featuredProperties[index];
                        return Container(
                          width: 250,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  property['image']!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.6),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      property['price']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      property['details']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),

                  /// Bottom Navigation Bar
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.home, color: Colors.black),
                        const Icon(Icons.chat_bubble_outline,
                              color: Colors.black),
                        const Icon(Icons.favorite_border, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Category Item Widget
  static Widget _categoryItem(String imagePath, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white,
          child: Image.asset(
            imagePath,
            width: 38,
            height: 38,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}