import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zakat_app/core/app_extension.dart';
import 'package:zakat_app/model/donate_model.dart';

class FoodController extends GetxController {
  RxInt currentBottomNavItemIndex = 0.obs;
  RxList<DonateModel> cartFood = <DonateModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble subtotalPrice = 0.0.obs;

  // Switch between bottom navigation items
  void switchBetweenBottomNavigationItems(int currentIndex) {
    currentBottomNavItemIndex.value = currentIndex;
  }
  // void increaseItem(Food food) {
  //   food.quantity++;
  //   update();
  //   calculateTotalPrice();
  // }

  // void decreaseItem(Food food) {
  //   food.quantity = food.quantity-- < 1 ? 0 : food.quantity--;
  //   calculateTotalPrice();
  //   update();
  //   if (food.quantity < 1) {
  //     cartFood.removeWhere((element) => element == food);
  //   }
  // }
  // Function to calculate total and subtotal prices
  void calculateTotalPrice() {
    totalPrice.value = 0; // Reset total price
    for (var element in cartFood) {
      totalPrice.value += element.price as double; // Ensure element has a 'price' attribute
    }

    subtotalPrice.value = totalPrice.value; // Set subtotal equal to total
  }

  // Add a donation to the cart
  void addToCart(DonateModel donation) {
    cartFood.add(donation); // Add the donation model
    cartFood.assignAll(cartFood.distinctBy((item) => item.id)); // Remove duplicates
    calculateTotalPrice(); // Recalculate the total price
  }

  // Remove an item from the cart by index
  void removeCartItemAtSpecificIndex(int index) {
    cartFood.removeAt(index); // Remove item at specific index
    calculateTotalPrice(); // Recalculate the total price
    update(); // Update the UI
  }
}
