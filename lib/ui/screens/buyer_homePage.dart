import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_application6/ui/screens/categorywise_listing.dart';
import 'package:mobile_application6/ui/screens/favorite_listing.dart';
import 'package:mobile_application6/ui/screens/featured_properties.dart';
import 'package:mobile_application6/ui/screens/property_details.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';
import '../widget/appDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  final FocusNode searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu, color: Colors.black),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
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
                    const SizedBox(height: 30),
                    TextField(
                      focusNode: searchFocus,
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "What are you looking for?",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        suffixIcon: searchText.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchText = '';
                            });
                          },
                        )
                            : const Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value.trim();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (searchText.isNotEmpty)
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('properties')
                              .where('isActive', isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const SizedBox();
                            final allProperties = snapshot.data!.docs;
                            final filteredProperties = allProperties.where((doc) {
                              final data = doc.data()! as Map<String, dynamic>;
                              final title = (data['title'] ?? '').toString().toLowerCase();
                              final location = (data['location'] ?? '').toString().toLowerCase();
                              final type = (data['type'] ?? '').toString().toLowerCase();
                              final query = searchText.toLowerCase();
                              return title.contains(query) ||
                                  location.contains(query) ||
                                  type.contains(query);
                            }).toList();

                            if (filteredProperties.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text("No results found")),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredProperties.length,
                              itemBuilder: (context, index) {
                                final property = filteredProperties[index].data()! as Map<String, dynamic>;
                                return ListTile(
                                  title: Text(property['title'] ?? ''),
                                  subtitle: Text(property['location'] ?? ''),
                                  trailing: Text("\$${property['price'] ?? ''}"),
                                  onTap: () {
                                    searchFocus.unfocus();
                                    searchController.clear();
                                    setState(() {
                                      searchText = '';
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PropertyDetailsScreen(property: property),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      if (searchText.isEmpty) ...[
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _categoryItem('assets/images/villa.png', 'Villa'),
                            _categoryItem('assets/images/flat.png', 'Apartment'),
                            _categoryItem('assets/images/plot.png', 'Plot'),
                            _categoryItem('assets/images/mess.png', 'Mess'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Featured Properties",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => FeaturedProperties()),
                                );
                              },
                              child: const Text(
                                "View all",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 220,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('properties')
                                .orderBy('price', descending: true)
                                .limit(3)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                              final featured = snapshot.data!.docs;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: featured.length,
                                itemBuilder: (context, index) {
                                  final data = featured[index].data()! as Map<String, dynamic>;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PropertyDetailsScreen(property: data),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 250,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: const [
                                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4)),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: data['images'] != null && (data['images'] as List).isNotEmpty
                                                ? Image.network(
                                              data['images'][0],
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                                : Image.asset(
                                              "assets/images/placeholder.png",
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
                                                  "\$${data['price'] ?? ''}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "${data['bedrooms'] ?? 0} Bed • ${data['bathrooms'] ?? 0} Bath",
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FavoriteListingsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CategoryListingsScreen(category: title)),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Image.asset(imagePath, width: 38, height: 38, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}