import 'package:cubit_test/extension.dart';
import 'package:cubit_test/repositories/models/trade_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class BookTileNew extends StatelessWidget {
  BookTileNew({super.key, required this.order, required this.onTap});

  final TradeOrder order;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(order.giving.imageUrl))),
                  14.width,
                  Expanded(
                    flex: 3,
                    child: Text(
                      order.giving.name,
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
              18.height,
              Text("обменяю на...",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A4A4A))),
              18.height,
              SizedBox(
                  // width: double.infinity,
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...order.taking.map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(e.imageUrl, fit: BoxFit.fill),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
