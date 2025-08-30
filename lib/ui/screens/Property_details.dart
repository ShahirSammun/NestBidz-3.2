import 'package:flutter/material.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      widget.property["image"],
      "assets/images/apartment.jpg",
      "assets/images/mess2.jpg",
      "assets/images/plot22.jpg",
    ];

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Top Image
              SizedBox(
                height: screenHeight * 0.45,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index],
                      width: double.infinity,
                      height: screenHeight * 0.45,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              // Empty space to fill under image
              Expanded(child: Container()),
            ],
          ),

          // White Details Card
          Positioned(
            top: screenHeight * 0.38, // slightly overlap
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    // Title + Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.property["title"],
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.property["location"],
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border,
                              color: Colors.red, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    // Info Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.bed, size: 26, color: Colors.black87),
                            SizedBox(height: 4),
                            Text("4 Bedroom", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.bathtub, size: 26, color: Colors.black87),
                            SizedBox(height: 4),
                            Text("2 Bathroom", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.local_parking,
                                size: 26, color: Colors.black87),
                            SizedBox(height: 4),
                            Text("Parking", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.square_foot,
                                size: 26, color: Colors.black87),
                            const SizedBox(height: 4),
                            Text(widget.property["area"],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Description
                    const Text(
                      "Description",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "This is a beautiful ${widget.property["type"]} located at ${widget.property["location"]}. "
                          "It offers a spacious area of ${widget.property["area"]} and is priced at ${widget.property["price"]}. "
                          "Nearby amenities include markets, bus stations, cinemas, and more.",
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),

                    // Price + Message Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.property["price"],
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 12),
                          ),
                          child: const Text("Message",
                              style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ),
          ),

          // Floating Dots on top of white card
          Positioned(
            top: screenHeight * 0.41, // just above the card
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 18 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.black : Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
          ),

          // Back Button
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}