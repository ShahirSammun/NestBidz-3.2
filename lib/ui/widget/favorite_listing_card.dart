import 'package:flutter/material.dart';

class FavoriteListingCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String imageAsset;
  final VoidCallback? onRemove;

  const FavoriteListingCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.imageAsset,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: SizedBox(
                width: 100,
                height: 107,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageAsset.startsWith('http')
                      ? Image.network(imageAsset, fit: BoxFit.cover)
                      : Image.asset(imageAsset, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(location,
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(price,
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: onRemove,
                        child: const Text(
                          "Remove",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
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