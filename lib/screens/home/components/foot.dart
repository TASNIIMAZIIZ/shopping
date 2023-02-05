import 'package:flutter/material.dart';

import 'package:shoping/constants.dart';
import 'package:shoping/models/Product.dart';
import 'package:shoping/screens/home/components/categorries.dart';

import '../../details/details_screen.dart';
import 'item_card.dart';

class foot extends StatefulWidget {
  const foot({Key? key}) : super(key: key);

  @override
  State<foot> createState() => _footState();
}

class _footState extends State<foot> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: foots.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) =>
                    ItemCard(product: foots[index], key: null,
                        press: ()=>Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailsScreen(product: foots[index], key:null,),
                        ))),
            ),
          ),
        ),
      ],
    );
  }
}
