import 'package:cubit_test/repositories/models/trade_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.tradeOrder});

  final TradeOrder tradeOrder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(boxShadow: [
          // BoxShadow(
          //     offset: const Offset(1, 4),
          //     // blurStyle: BlurStyle.outer,
          //     color: Colors.black.withAlpha(80),
          //     blurRadius: 2)
        ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.network(tradeOrder.giving.imageUrl,
                          height: 100, width: 80, fit: BoxFit.contain),
                      const SizedBox(height: 8),
                      Text(tradeOrder.giving.name,
                          maxLines: 1,
                          // style: const TextStyle(
                          //     overflow: TextOverflow.ellipsis,
                          //     fontWeight: FontWeight.w600)),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              textStyle:
                                  TextStyle(overflow: TextOverflow.ellipsis)))
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward),
                Expanded(
                  child: Column(
                    children: [
                      Image.network(tradeOrder.taking.imageUrl,
                          height: 100, width: 80, fit: BoxFit.contain),
                      const SizedBox(height: 8),
                      Text(tradeOrder.taking.name,
                          maxLines: 1,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(tradeOrder.timePassed,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]))
          ],
        ));
  }
}
