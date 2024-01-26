// import 'package:ecom/common/widgets/custom_appbar.dart';
// import 'package:ecom/constants/string_constants.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import '../../catalog/presentation/widgets/my_grid_tile.dart';

// class FavScreen extends StatelessWidget {
//   const FavScreen({super.key});

//   static const routeName = '/fav-screen';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorites'),
//         backgroundColor: Colors.transparent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
            
              
//                 final favProds = prodP.getFavProd();

//                 if (favProds.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       StringConstants.noFavText,
//                     ),
//                   );
//                 }
//                 return Expanded(
//                   child: MasonryGridView.builder(
//                     gridDelegate:
//                         const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     ),
//                     itemCount: favProds.length,
//                     itemBuilder: (context, index) {
//                       final prod = favProds[index];

//                       return MyGridTile(
//                         product: prod,
//                       );
//                     },
//                   ),
                
              
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
