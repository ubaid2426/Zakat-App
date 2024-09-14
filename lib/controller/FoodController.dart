import 'package:get/get.dart';
import 'package:zakat_app/core/app_extension.dart';
// import 'package:mainpage/core/App_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:mainpage/src/models/food.dart';
import 'package:zakat_app/model/food.dart';

class FoodController extends GetxController {
  RxInt currentBottomNavItemIndex = 0.obs;
  RxList<Food> cartFood = <Food>[].obs;
  RxList<Food> favoriteFood = <Food>[].obs;
  // RxList<FoodCategory> categories = AppData.categories.obs;
  // RxList<Food> filteredFoods = AppData.foodItems.obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble subtotalPrice = 0.0.obs;
  // Rx<ThemeData> theme = AppTheme.lightTheme.obs;
  bool isLightTheme = true;

  void switchBetweenBottomNavigationItems(int currentIndex) {
    currentBottomNavItemIndex.value = currentIndex;
  }

  void increaseItem(Food food) {
    food.quantity++;
    update();
    calculateTotalPrice();
  }

  void decreaseItem(Food food) {
    food.quantity = food.quantity-- < 1 ? 0 : food.quantity--;
    calculateTotalPrice();
    update();
    if (food.quantity < 1) {
      cartFood.removeWhere((element) => element == food);
    }
  }

  String calculatePricePerEachItem(Food food) {
    double price = 0;
    price = food.quantity * food.price;
    return price.toString();
  }

  calculateTotalPrice() {
    totalPrice.value = 5;
    for (var element in cartFood) {
      totalPrice.value += element.quantity * element.price;
    }

    subtotalPrice.value = 0;
    if (totalPrice.value > 0) {
      subtotalPrice.value = totalPrice.value - 5;
    }
  }

  addToCart(Food food) {
    if (food.quantity > 0) {
      cartFood.add(food);
      cartFood.assignAll(cartFood.distinctBy((item) => item));
      calculateTotalPrice();
    }
  }

  // filterItemByCategory(FoodCategory category) {
  //   for (var element in AppData.categories) {
  //     element.isSelected = false;
  //   }
  //   category.isSelected = true;

  //   if (category.type == FoodType.all) {
  //     filteredFoods.assignAll(AppData.foodItems.obs);
  //   } else {
  //     filteredFoods.assignAll(AppData.foodItems.where((item) {
  //       return item.type == category.type;
  //     }).toList());
  //   }
  //   update();

  //   filteredFoods.refresh();
  // }

  isFavoriteFood(Food food) {
    food.isfavorite = !food.isfavorite;
    update();
    if (food.isfavorite) {
      favoriteFood.add(food);
    }
    if (!food.isfavorite) {
      favoriteFood.removeWhere((element) => element == food);
    }
  }

  removeCartItemAtSpecificIndex(int index) {
    cartFood.removeAt(index);
    calculateTotalPrice();
    update();
  }

//   void changeTheme() {
//     if (theme.value == AppTheme.darkTheme) {
//       theme.value = AppTheme.lightTheme;
//       isLightTheme = true;
//     } else {
//       theme.value = AppTheme.darkTheme;
//       isLightTheme = false;
//     }
//   }
}
