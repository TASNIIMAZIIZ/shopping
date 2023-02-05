import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shoping/constants.dart';
import 'package:shoping/models/Product.dart';
import 'package:shoping/screens/home/components/categorries.dart';

import '../../details/details_screen.dart';
import 'item_card.dart';


class bag extends StatefulWidget {

  const bag({
    Key? key
  }) : super(key: key);

  @override
  State<bag> createState() => _bagState();
}

class _bagState extends State<bag> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) =>
                    ItemCard(product: products[index], key: null,
                        press: ()=>Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailsScreen(product: products[index], key:null,),))),
            ),
          ),
        ),
      ],
    );
  }
}
