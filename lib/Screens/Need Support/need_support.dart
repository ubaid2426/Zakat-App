import 'package:flutter/material.dart';
import 'package:zakat_app/Screens/Need%20Support/components/needsupport_card.dart';
import 'package:zakat_app/core/app_dummy.dart';
import 'package:zakat_app/model/all_category.dart';

class Show2 extends StatelessWidget {
  const Show2({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final AllCategoryModel category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width / 3 - 19,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 253, 251, 251),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Text(
                category.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 150,
              height: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(category.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Category widget that shows the grid of categories
class NeedCategory extends StatelessWidget {
  const NeedCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3.4,
            ),
            itemCount: availableCategories.length,
            itemBuilder: (context, index) {
              final category = availableCategories[index];
              return Show2(
                category: category,
                onSelectCategory: () {
                  // Navigate to RequestDonation page with selected category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NeedSupport(
                        selectedCategory: category.title,  // Pass category title here
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
