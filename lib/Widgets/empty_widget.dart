import 'package:flutter/material.dart';
// import 'package:mainpage/core/App_assest.dart';
import 'package:zakat_app/core/AppAssests.dart';
// import 'package:flutter_japanese_restaurant_app/core/app_asset.dart';

enum EmptyWidgetType { cart, favorite }

class EmptyWidget extends StatelessWidget {
  final EmptyWidgetType type;
  final String title;
  final bool condition;
  final Widget child;

  const EmptyWidget({
    super.key,
    this.type = EmptyWidgetType.cart,
    required this.title,
    this.condition = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? child
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                    Image.asset(AppAssest.picture2, width: 300),
                    // : Image.asset(AppAssest.emptyFavorite, width: 300),
                const SizedBox(height: 10),
                Text(title, style: Theme.of(context).textTheme.displayMedium)
              ],
            ),
          );
  }
}
