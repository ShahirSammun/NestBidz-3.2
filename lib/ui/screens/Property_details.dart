import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> property;
  const PropertyDetailsScreen({super.key, required this.property});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool isFavorite = false;
  final User? user = FirebaseAuth.instance.currentUser;
  String userRole = 'Buyer';

  @override
  void initState() {
    super.initState();
    fetchUserRole();
    checkIfFavorite();
  }

  void fetchUserRole() async {
    if (user == null) return;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (doc.exists) {
      setState(() {
        userRole = doc.data()?['role'] ?? 'Buyer';
      });
    }
  }

  void checkIfFavorite() async {
    if (user == null) return;
    final propertyDocId =
        widget.property['title'] + (widget.property['location'] ?? '');
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .doc(propertyDocId)
        .get();

    setState(() {
      isFavorite = doc.exists;
    });
  }

  void toggleFavorite() async {
    if (user == null) return;
    final propertyDocId =
        widget.property['title'] + (widget.property['location'] ?? '');
    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .doc(propertyDocId);

    if (isFavorite) {
      await favRef.delete();
    } else {
      await favRef.set(widget.property);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.property['images'] != null &&
            (widget.property['images'] as List).isNotEmpty
        ? List<String>.from(widget.property['images'])
        : ["assets/images/placeholder.png"];

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
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
                    final image = images[index];
                    return image.startsWith('http')
                        ? Image.network(
                            image,
                            width: double.infinity,
                            height: screenHeight * 0.45,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            image,
                            width: double.infinity,
                            height: screenHeight * 0.45,
                            fit: BoxFit.cover,
                          );
                  },
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Positioned(
            top: screenHeight * 0.38,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.property["title"] ?? '',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                    onPressed: toggleFavorite,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.property["location"] ?? '',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.bed,
                                size: 26, color: Colors.black87),
                            const SizedBox(height: 4),
                            Text("${widget.property['bedrooms'] ?? 0} Bedroom",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.bathtub,
                                size: 26, color: Colors.black87),
                            const SizedBox(height: 4),
                            Text(
                                "${widget.property['bathrooms'] ?? 0} Bathroom",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.local_parking,
                                size: 26, color: Colors.black87),
                            const SizedBox(height: 4),
                            Text("${widget.property['parking'] ?? 0} Parking",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.square_foot,
                                size: 26, color: Colors.black87),
                            const SizedBox(height: 4),
                            Text("${widget.property['area'] ?? ''}",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.property["description"] ??
                          "This is a beautiful ${widget.property["type"] ?? ''} located at ${widget.property["location"] ?? ''}. "
                              "It offers a spacious area of ${widget.property["area"] ?? ''} and is priced at ${widget.property["price"] ?? ''}. "
                              "Nearby amenities include markets, bus stations, cinemas, and more.",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Contact Number",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.property["contactNumber"] ?? '',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price:৳${widget.property['price'] ?? '0'}",
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        if (userRole != 'Seller')
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.41,
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
                    color:
                        _currentIndex == index ? Colors.black : Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
          ),
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
                child:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
