import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_test/features/home/widgets/book_item.dart';
import 'package:cubit_test/features/home/widgets/book_tile.dart';
import 'package:cubit_test/features/home/widgets/book_tile_new.dart';
import 'package:cubit_test/features/home/widgets/search_field.dart';
import 'package:cubit_test/repositories/models/book.dart';
import 'package:cubit_test/repositories/models/trade_order.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("BookXchange", style: theme.textTheme.displayMedium),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: SearchField()),
                SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.filter_list_sharp, size: 30),
                )
              ],
            ),
            SizedBox(height: 16),
            Expanded(
                // child: BookGridWidget(),
                child: _buildListBody())
          ],
        ),
      ),
    );
  }

  Widget _buildListBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: ListView(
                  children: snapshot.data!.docs.map((docsnap) {
                    Map<String, dynamic> data =
                        docsnap.data()! as Map<String, dynamic>;
                    return BookTileNew(
                        order: TradeOrder(
                      date: data['date'],
                      id: "1",
                      giving: Book(
                          name: data['giving'],
                          category: Category.all,
                          imageUrl:
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Open_book_nae_02.svg/800px-Open_book_nae_02.svg.png'),
                      taking: Book(
                          name: data['taking'],
                          category: Category.all,
                          imageUrl:
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Open_book_nae_02.svg/800px-Open_book_nae_02.svg.png'),
                    ));
                  }).toList(),
                ),
              ));
        });
  }
}

class BookGridWidget extends StatelessWidget {
  const BookGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemCount: 10,
      itemBuilder: (context, index) => BookItem(
          book: Book(
              name: "CheckName",
              category: Category.all,
              imageUrl:
                  'https://m.media-amazon.com/images/I/81YkqyaFVEL._AC_UF1000,1000_QL80_DpWeblab_.jpg')),
    );
  }
}
