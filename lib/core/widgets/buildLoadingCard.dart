import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class BuildLoadingCard extends StatelessWidget {
  final String day;
  final String month;

  const BuildLoadingCard({
    super.key,
    required this.day,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 205,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImagesManager.lSport,
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.10),
                highlightColor: Colors.white.withOpacity(0.35),
                period: const Duration(milliseconds: 1200),
                child: Container(color: Colors.white),
              ),
            ),

            // 3) date badge
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 48,
                height: 62,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1F4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(day, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                    Text(month, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),

            // 4) bottom strip
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Enjoy a variety of cuisines from local food trucks in a lively outdoor setting.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.favorite_border, color: Color(0xFF5D6BFF), size: 24),
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
