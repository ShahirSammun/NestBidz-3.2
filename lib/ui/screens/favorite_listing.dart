import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/favorite_listing_card.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class FavoriteListingsScreen extends StatelessWidget {
  const FavoriteListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using the same dummy data from ListingScreen
    final favorites = [
      {
        "title": "Bachelor-Friendly Room",
        "location": "Ambarkhana, Sylhet",
        "price": "BDT 5,000/month",
        "imageAsset": "assets/images/room25.jpg",
      },
      {
        "title": "Family Apartment for Rent",
        "location": "Dhaka",
        "price": "BDT 15,000/month",
        "imageAsset": "assets/images/flat25.jpg",
      },
      {
        "title": "Luxury Villa for Rent",
        "location": "Cox's Bazar",
        "price": "BDT 50,000/month",
        "imageAsset": "assets/images/villa22.jpg",
      },
      {
        "title": "Cozy Studio Flat",
        "location": "Sylhet",
        "price": "BDT 5000000",
        "imageAsset": "assets/images/apartment25.jpg",
      },
      {
        "title": "Pearl Villa 2 BHK for Sale",
        "location": "Cox's Bazar",
        "price": "BDT 10000000",
        "imageAsset": "assets/images/villaa.jpg",
      },
      {
        "title": "Spacious Plot for Sale",
        "location": "Comilla",
        "price": "BDT 800000",
        "imageAsset": "assets/images/plot25.jpg",
      },
    ];

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        "Favorite Listings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Favorite Listings
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final item = favorites[index];
                    return FavoriteListingCard(
                      title: item["title"] as String,
                      location: item["location"] as String,
                      price: item["price"] as String,
                      imageAsset: item["imageAsset"] as String,
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