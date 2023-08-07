import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_over/product/widgets/custom_magaza_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodMarket extends ConsumerStatefulWidget {
  const FoodMarket({super.key});

  @override
  ConsumerState<FoodMarket> createState() => _FoodMarketState();
}

class _FoodMarketState extends ConsumerState<FoodMarket> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('foods').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
              ),
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMagazaCard(
                    cardName: snapshot.data!.docs[index]['name'],
                    cardAsset: snapshot.data!.docs[index]['url'],
                    cardPrice: snapshot.data!.docs[index]['credit'],
                  ),
                );
              },
            );
          }
        });
  }
}
