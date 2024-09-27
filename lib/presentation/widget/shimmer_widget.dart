import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget{
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: Colors.grey[300],
                  ),
                  child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                      )),
                ),

                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(Radius.circular(100))
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(Radius.circular(100))
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.all(Radius.circular(100))
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: 10,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}