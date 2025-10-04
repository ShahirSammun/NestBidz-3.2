import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_application6/ui/widget/listCard.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';
import 'add_property.dart'; // for editing property

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('properties')
                      .where('createdBy', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No properties added yet",
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index];
                        final id = data.id;

                        return ListingCard(
                          title: data['title'] ?? '',
                          location: data['location'] ?? '',
                          price: data['price'].toString(),
                          imageUrl: (data['images'] != null &&
                              (data['images'] as List).isNotEmpty)
                              ? (data['images'] as List)[0] as String
                              : '',
                          isActive: data['isActive'] ?? true,
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddPropertyScreen(
                                  category: data['category'] ?? '',
                                  propertyData: data,
                                ),
                              ),
                            );
                          },
                          onDelete: () async {
                            await FirebaseFirestore.instance
                                .collection('properties')
                                .doc(id)
                                .update({'isActive': false});
                          },
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