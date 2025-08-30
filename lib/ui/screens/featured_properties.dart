import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';
import 'property_details.dart'; // <-- import details screen

class FeaturedProperties extends StatelessWidget {
  final List<Map<String, dynamic>> properties = [
    {
      "title": "Pearl Villa 2 BHK with top rated price",
      "type": "Villa",
      "area": "120 m²",
      "location": "Mirpur - Dhaka",
      "price": "TK 4000000.00",
      "image": "assets/images/villaa.jpg"
    },
    {
      "title": "Lavish 2 BHK Apartment with best place for your family",
      "type": "Apartment",
      "area": "130 m²",
      "location": "Housing Estate - Sylhet",
      "price": "TK 3500000.00",
      "image": "assets/images/apartment.jpg"
    },
    {
      "title": "Modern mess near city center",
      "type": "Mess",
      "area": "80 m²",
      "location": "Zindabazar - Sylhet",
      "price": "TK 8000.00",
      "image": "assets/images/mess2.jpg"
    },
    {
      "title": "Spacious Plot Perfect for Building Your Dream Home",
      "type": "Plot",
      "area": "200 m²",
      "location": "Gazipur - Dhaka",
      "price": "TK 50000000.00",
      "image": "assets/images/plot22.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const SizedBox(height: 50),

            // Top Row with Back Button and Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Featured Properties",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PropertyDetailsScreen(property: property),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              property["image"],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.square_foot,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(property["area"],
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12)),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.home,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(property["type"],
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  property["title"],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  property["location"],
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  property["price"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}