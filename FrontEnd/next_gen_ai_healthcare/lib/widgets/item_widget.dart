import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final List<String> images;
  final String title;
  final String seller;
  final int sold;
  final double rating;
  final String description;
  final VoidCallback onTap;

  const ItemWidget({
    super.key,
    required this.images,
    required this.title,
    required this.seller,
    required this.sold,
    required this.rating,
    required this.description,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 377,
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor.withOpacity(.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 119,
              decoration:  BoxDecoration(
                image:  DecorationImage(
                  fit:BoxFit.contain,
                  image: NetworkImage(
                    
                    images.isEmpty?"https://www.accu-chek.com.pk/sites/g/files/iut956/f/styles/image_300x400/public/media_root/product_media_files/product_images/active-mgdl-300x400.png?itok=bgvuYJFy":images[0]), 
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                seller, 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '$sold sold', 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                   Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$rating",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
