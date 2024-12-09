// import 'package:flutter/material.dart';

// class ItemWidget extends StatelessWidget {
//   final String image;
//   final String title;
//   final String seller;
//   final int sold;
//   final double rating;

//   const ItemWidget({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.seller,
//     required this.sold,
//     required this.rating,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Add functionality for when the item is tapped, if needed
//       },
//       child: Container(
//         height: 377,
//         width: 150,
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           border: Border.all(
//             width: 2,
//             color: Theme.of(context).primaryColor.withOpacity(.2),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(image), // Assuming image is a URL
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
//               ),
//             ),
//             // Product Title
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 title,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//               ),
//             ),
//             // Seller Information
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 'Seller: $seller',
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//               ),
//             ),
//             // Number of Products Sold
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Text(
//                 '$sold sold',
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//               ),
//             ),
//             // Rating (with stars)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.star,
//                     color: Colors.yellow,
//                     size: 16,
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     '$rating',
//                     style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
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
              height: 150,
              decoration:const  BoxDecoration(
                image:  DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'), 
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Awesome Product Title Awesome Product Title Awesome Product Title Awesome Product Title', 
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
                'Seller: BestSeller123', 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '100 sold', 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '4.5',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          color: Colors.grey[600],
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
