import 'package:flutter/material.dart';

import 'package:shoping/constants.dart';
import 'package:shoping/models/Product.dart';
import 'package:shoping/screens/home/components/categorries.dart';

import '../../details/details_screen.dart';
import 'item_card.dart';
class dress extends StatefulWidget {

  const dress({Key? key,}) : super(key: key);

  @override
  State<dress> createState() => _dressState();
}

class _dressState extends State<dress> {
  // get email => widget.email;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: dresses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) =>
                    ItemCard(product: dresses[index], key: null,
                      press: ()=>Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DetailsScreen(product: dresses[index], key:null,),))),
    ),
            ),
          ),
      ],
    );
  }
}
