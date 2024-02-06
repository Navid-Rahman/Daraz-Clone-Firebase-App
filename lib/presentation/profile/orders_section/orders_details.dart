import 'package:flutter/material.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/presentation/profile/orders_section/widgets/order_placed_details.dart';
import 'package:daraz_idea_firebase/presentation/profile/orders_section/widgets/order_status.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Order Status",
                style: TextStyle(
                  color: darkFontGrey,
                  fontFamily: semibold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  orderStatus(
                    icon: Icons.check_circle,
                    color: redColor,
                    title: "Placed",
                    showDone: data['order_placed'],
                  ),
                  orderStatus(
                    icon: Icons.thumb_up_alt_rounded,
                    color: Colors.blueAccent,
                    title: "Confirmed",
                    showDone: data['order_confirmed'],
                  ),
                  orderStatus(
                    icon: Icons.car_crash_rounded,
                    color: Colors.orangeAccent,
                    title: "On Delivery",
                    showDone: data['order_on_delivery'],
                  ),
                  orderStatus(
                    icon: Icons.done_all_rounded,
                    color: Colors.greenAccent,
                    title: "Delivered",
                    showDone: data['order_delivered'],
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                "Order Details",
                style: TextStyle(
                  color: darkFontGrey,
                  fontFamily: semibold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              orderPlacedDetails(
                title1: "Order Code",
                title2: "Shipping Method",
                details1: data['order_code'],
                details2: data['shipping_method'],
              ),
              orderPlacedDetails(
                title1: "Order Date",
                title2: "Payment Method",
                details1: data['order_date'].toDate().toString().split(' ')[0],
                details2: data['payment_method'],
              ),
              orderPlacedDetails(
                title1: "Payment Status",
                title2: "Delivery Status",
                details1: "Unpaid",
                details2: "Order Placed",
              ),
              const SizedBox(height: 20),
              const Text(
                "Shipping Address",
                style: TextStyle(
                  color: darkFontGrey,
                  fontFamily: semibold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['order_by_name']),
                  Text(data['order_by_email']),
                  Text(data['order_by_phone_number']),
                  Text(data['order_by_address']),
                  Text(data['order_by_city']),
                  Text(data['order_by_state']),
                  Text(data['order_by_postal_code']),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      color: darkFontGrey,
                      fontFamily: semibold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Rs. ${data['total_amount']}",
                    style: const TextStyle(
                      color: redColor,
                      fontFamily: bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Ordered Products",
                style: TextStyle(
                  color: darkFontGrey,
                  fontFamily: semibold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['price'],
                        details1: "${data['orders'][index]['quantity']}X",
                        details2: "Refundable",
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 10,
                        width: 50,
                        color: Color(int.parse(data['orders'][index]['color'])),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SUB TOTAL",
                    style: TextStyle(
                      color: darkFontGrey,
                      fontFamily: semibold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
