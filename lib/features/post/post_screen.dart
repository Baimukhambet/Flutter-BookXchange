import 'package:cubit_test/extension.dart';
import 'package:cubit_test/features/order_create/widgets/add_book_button.dart';
import 'package:cubit_test/features/post/widgets/main_button.dart';
import 'package:cubit_test/repositories/models/trade_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.order}) : super(key: key);

  final TradeOrder order;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Пост"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(widget.order.giving.imageUrl)),
                  24.width,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.order.giving.name,
                            maxLines: 4, style: theme.textTheme.displayLarge)
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Color(0xFFD9D9D9),
              thickness: 4,
            ),
            8.height,
            Text("Обменяю на", style: theme.textTheme.displayMedium),
            8.height,
            const Divider(
              color: Color(0xFFD9D9D9),
              thickness: 4,
            ),
            Expanded(
              child: Container(
                child: Stack(children: [
                  PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal, // or Axis.vertical
                    children: [
                      ...widget.order.taking
                          .map((e) => Center(child: Text(e.name)))
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("LOW"),
                  )
                ]),
              ),
            ),
            MainButton(onTap: () {}, title: "Предложить обмен"),
            16.height,
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.pageCount});

  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [for (int i = 0; i < pageCount; i++) TabPageSelector()],
    ));
  }
}
