import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zakat_app/Screens/PaymentMethod/payment_method.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:zakat_app/Widgets/empty_widget.dart';
import 'package:zakat_app/components/navigation.dart';
import 'package:zakat_app/controller/controller.dart';

final FoodController controller = Get.put(FoodController());

// final FoodController foodController = Get.find<FoodController>();
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF33A248), // First color (#33A248)
              Color(0xFFB2EA50), // Second color (#B2EA50)
            ],
            begin:
                Alignment.bottomRight, // Start the gradient from bottom-right
            end: Alignment.topLeft, // End the gradient at top-left
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Cart screen",
            // style: Theme.of(context).textTheme.displayMedium,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Navigation()), // Navigate to the screen
              );
            },
          )
        ],
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: MediaQuery.of(context).size.height * 0.30,
      child: SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248), // First color (#33A248)
                Color(0xFFB2EA50), // Second color (#B2EA50)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Subtotal",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            "\$${controller.subtotalPrice.value}",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Taxes",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "\$0.0", // Assuming no taxes for donations
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Divider(
                      thickness: 4.0,
                      height: 30.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(() {
                          return Text("\$${controller.totalPrice.value}",
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ));
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to checkout page or perform checkout
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentMethod()),
                          );
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cartListView(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      shrinkWrap: true,
      itemCount: controller.cartFood.length,
      itemBuilder: (_, index) {
        return Dismissible(
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              controller.removeCartItemAtSpecificIndex(index);
            }
          },
          key: Key(controller.cartFood[index].title),
          background: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 2, 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Color.fromARGB(255, 137, 212, 63),
                      ),
                      width: MediaQuery.of(context).size.width - 60,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 6),
                        child: Text(
                          controller.cartFood[index].title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 188, 2),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://127.0.0.1:8000/data${controller.cartFood[index].image}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Donation Cost",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 85, 84, 84),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$${controller.cartFood[index].price}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Conditionally show "Zakat" label
                        if (controller.cartFood[index].isZakat)
                          Container(
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Zakat Donation",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.all(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: controller.cartFood.isNotEmpty
          ? _bottomAppBar(context)
          : const SizedBox(),
      appBar: _appBar(context),
      body: EmptyWidget(
        title: "Empty cart",
        condition: controller.cartFood.isNotEmpty,
        child: SingleChildScrollView(
          child: SizedBox(
            height: height * 0.5,
            child: GetBuilder(
              builder: (FoodController controller) => cartListView(context),
            ),
          ),
        ),
      ),
    );
  }
}
