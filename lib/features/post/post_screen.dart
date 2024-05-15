import 'package:cubit_test/extension.dart';
import 'package:cubit_test/features/order_create/widgets/add_book_button.dart';
import 'package:cubit_test/features/post/post_tab_provider.dart';
import 'package:cubit_test/features/post/widgets/carousel_item.dart';
import 'package:cubit_test/features/post/widgets/main_button.dart';
import 'package:cubit_test/repositories/models/trade_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.order}) : super(key: key);

  final TradeOrder order;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PageController _pageController = PageController();
  final PostTabProvider postTabProvider = PostTabProvider();

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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Stack(children: [
                  PageView(
                    onPageChanged: (value) => postTabProvider.change(value),
                    controller: _pageController,
                    scrollDirection: Axis.horizontal, // or Axis.vertical
                    children: [
                      ...widget.order.taking.map((e) => CarouselItem(book: e))
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ChangeNotifierProvider(
                      create: (context) => postTabProvider,
                      builder: (context, child) => PageIndicator(
                        pageCount: widget.order.taking.length,
                      ),
                    ),
                  )
                ]),
              ),
            ),
            14.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MainButton(onTap: () {}, title: "Предложить обмен"),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  PageIndicator({super.key, required this.pageCount});

  final int pageCount;
  // final PostTabProvider postTabProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostTabProvider>(
      builder: (context, provider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < pageCount; i++)
            Icon((i == provider.currentIndex)
                ? Icons.circle
                : Icons.circle_outlined)
        ],
      ),
    );
  }
}
