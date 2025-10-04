import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_application6/ui/widget/favorite_listing_card.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';
import 'property_details.dart';

class FavoriteListingsScreen extends StatelessWidget {
  const FavoriteListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Please login to view favorites"),
        ),
      );
    }

    final favCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: favCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No favorites yet."),
                      );
                    }

                    final favorites = snapshot.data!.docs;

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final doc = favorites[index];
                        final data = doc.data() as Map<String, dynamic>;

                        String price = '';
                        if (data['price'] != null) price = data['price'].toString();
                        String title = data['title'] ?? '';
                        String location = data['location'] ?? '';
                        String image = 'assets/images/placeholder.png';
                        if (data['images'] != null && (data['images'] as List).isNotEmpty) {
                          image = data['images'][0];
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PropertyDetailsScreen(property: data),
                              ),
                            );
                          },
                          child: FavoriteListingCard(
                            title: title,
                            location: location,
                            price: price,
                            imageAsset: image,
                            onRemove: () async {
                              await favCollection.doc(doc.id).delete();
                            },
                          ),
                        );
                      },
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