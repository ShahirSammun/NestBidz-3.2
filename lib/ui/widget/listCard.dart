import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String imageAsset;
  final bool isActive;

  const ListingCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.imageAsset,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = isActive ? Colors.white : Colors.grey.shade100;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6), // small horizontal margin too
      child: SizedBox(
        height: 130, // card height
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6), // <-- left & right spacing
              child: SizedBox(
                width: 100,
                height: 107,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    color: isActive ? null : Colors.grey.withOpacity(0.5),
                    colorBlendMode: isActive ? null : BlendMode.modulate,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Status
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isActive ? Colors.black : Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Active",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    // Location
                    Text(
                      location,
                      style: TextStyle(
                        color: isActive ? Colors.black : Colors.grey.shade500,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 2),

                    // Price
                    Text(
                      price,
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isActive ? Colors.grey.shade200 : Colors.grey.shade300,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: isActive ? Colors.black87 : Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isActive ? Colors.red.shade50 : Colors.grey.shade300,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: isActive ? Colors.red : Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}