import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/listCard.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listings = [
      {
        "title": "Bachelor-Friendly Room",
        "location": "Ambarkhana, Sylhet",
        "price": "BDT 5,000/month",
        "imageAsset": "assets/images/room25.jpg",
        "isActive": true,
      },
      {
        "title": "Family Apartment for Rent",
        "location": "Dhaka",
        "price": "BDT 15,000/month",
        "imageAsset": "assets/images/flat25.jpg",
        "isActive": true,
      },
      {
        "title": "Luxury Villa for Rent",
        "location": "Cox's Bazar",
        "price": "BDT 50,000/month",
        "imageAsset": "assets/images/villa22.jpg",
        "isActive": true,
      },
      {
        "title": "Cozy Studio Flat",
        "location": "Sylhet",
        "price": "BDT 5000000",
        "imageAsset": "assets/images/apartment25.jpg",
        "isActive": true,
      },
      {
        "title": "Pearl Villa 2 BHK for Sale",
        "location": "Cox's Bazar",
        "price": "BDT 10000000",
        "imageAsset": "assets/images/villaa.jpg",
        "isActive": true,
      },
      {
        "title": "Spacious Plot for Sale",
        "location": "Comilla",
        "price": "BDT 800000",
        "imageAsset": "assets/images/plot25.jpg",
        "isActive": true,
      },
    ];

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        "My Listings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 33,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              // Listings
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  itemCount: listings.length,
                  itemBuilder: (context, index) {
                    final item = listings[index];
                    return ListingCard(
                      title: item["title"] as String,
                      location: item["location"] as String,
                      price: item["price"] as String,
                      imageAsset: item["imageAsset"] as String,
                      isActive: item["isActive"] as bool,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}