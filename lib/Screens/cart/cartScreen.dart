import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/Accounts/account_detail.dart';
import 'package:zakat_app/Widgets/empty_widget.dart';
import 'package:zakat_app/controller/controller.dart';
// import 'package:mainpage/core/App_extension.dart';
// import 'package:mainpage/src/Screens/PopupScreen.dart';
// import 'package:mainpage/src/Widgets/EmptyWidget.dart';
// import 'package:mainpage/src/Widgets/counter_button.dart';
// import 'package:mainpage/src/controller/controller.dart';
// import 'package:mainpage/src/controller/FoodController.dart';

final FoodController controller = Get.put(FoodController());

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Cart screen",
        style: Theme.of(context).textTheme.displayMedium,
      ),
      // backgroundColor: ThemeData()
      //     .copyWith(
      //       // scaffoldBackgroundColor: const Color(0xFF8BCCC1),
      //     )
          // .scaffoldBackgroundColor,
    );
  }

  Widget _bottomAppBar(BuildContext context) {
    return BottomAppBar(
      // color: const Color(0xFF8BCCC1),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Container(
        height: 500,
        // width:double.infinity,
        // color: Colors.green,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            // color:Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
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
                          ),
                          // style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Obx(() {
                          return Text(
                            "\$${controller.subtotalPrice.value}",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            // style: Theme.of(context).textTheme.displayMedium,
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Taxes",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          // style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "\$${5.00}",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          // style: Theme.of(context).textTheme.displayMedium,
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
                          ),
                          // style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Obx(() {
                          return Text(
                              controller.totalPrice.value == 5.0
                                  ? "\$0.0"
                                  : "\$${controller.totalPrice}",
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )
                              // style: h2Style.copyWith(
                              //   color: LightThemeColor.accent,
                              // ),
                              );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    // width: double.infinity,
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.red,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          // Colors.red;
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>const AccountDetail()),
                          );
                          // print('Press button');
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,

                            // backgroundColor: Colors.green,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const FaIcon(FontAwesomeIcons.trash),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              // controller.isLightTheme
              // ? Colors.white
              // : DarkThemeColor.primaryLight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 20),
                Image.asset(controller.cartFood[index].image, scale: 10),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.cartFood[index].title,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      // style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "\$${controller.cartFood[index].price}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      // style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const Spacer(),
                // Column(
                //   children: [
                //     CounterButton(
                //       onIncrementSelected: () =>
                //           controller.increaseItem(controller.cartFood[index]),
                //       onDecrementSelected: () =>
                //           controller.decreaseItem(controller.cartFood[index]),
                //       size: const Size(20, 20),
                //       padding: 0,
                //       label: Text(
                //         controller.cartFood[index].quantity.toString(),
                //         style: const TextStyle(
                //           fontSize: 12,
                //         ),
                //         // style: Theme.of(context).textTheme.displayMedium,
                //       ),
                //     ),
                //     Text(
                //       "\$${controller.calculatePricePerEachItem(controller.cartFood[index])}",
                //       style: const TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black,
                //       ),
                //       // style: h2Style.copyWith(color: LightThemeColor.accent),
                //     )
                //   ],
                // )
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
    // double width = MediaQuery.of(context).size.width;
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
