import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_over/product/widgets/artbook_card.dart';
import 'package:day_over/product/widgets/custom_app_bar_search.dart';
import 'package:day_over/product/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtBookView extends ConsumerWidget {
  const ArtBookView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBarSearch(appBarText: "Art Book"),
              const SizedBox(
                height: 30,
              ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('stickers').snapshots(),
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
                        child: ArtBookCard(
                          cardName: snapshot.data!.docs[index]['name'],
                          cardAsset: snapshot.data!.docs[index]['url'],
                        ),
                      );
                    },
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
