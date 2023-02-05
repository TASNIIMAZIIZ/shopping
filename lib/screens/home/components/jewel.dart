import 'package:flutter/material.dart';
import 'package:shoping/constants.dart';
import 'package:shoping/models/Product.dart';
import '../../details/details_screen.dart';
import 'item_card.dart';

class Jewel extends StatefulWidget {
  const Jewel({Key? key}) : super(key: key);

  @override
  State<Jewel> createState() => _JewelState();
}

class _JewelState extends State<Jewel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: jewels.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) =>
                    ItemCard(product: jewels[index], key: null,
                        press: ()=>Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: jewels[index], key:null,),),)
            ),
          ),
        )),
      ],
    );
  }
}


// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//           child: Text(
//             "Women",
//             style: Theme.of(context)
//                 .textTheme
//                 .headline5
//                 ?.copyWith(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Categories(),
//
//
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//             child: GridView.builder(
//                 itemCount: jewels.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: kDefaultPaddin,
//                   crossAxisSpacing: kDefaultPaddin,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemBuilder: (context, index) =>
//                     ItemCard(product: jewels[index], key: null, press: () {  },)
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



