import 'package:flutter/material.dart';
import 'package:zakat_app/components/donate.dart';
import 'package:zakat_app/core/app_dummy.dart';
import 'package:zakat_app/model/doantion_model.dart';

class Clothes extends StatefulWidget {
  const Clothes({super.key});

  @override
  _ClothesState createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {
  String selectedSort = 'Not finished projects first';
  late List<DoantionModel> sortedClothes;
  int currentQueueIndex = 0; // Track which project to display

  @override
  void initState() {
    super.initState();
    sortedClothes = List.from(clothes);
    _sortList(selectedSort);
    _autoShowNextProject(); // Automatically track and show the next project
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248),
                Color(0xFFB2EA50),
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Clothes Donation"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedSort = value;
                _sortList(selectedSort);
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'finished projects',
                child: Text('Finished projects'),
              ),
              const PopupMenuItem(
                value: 'Not finished projects first',
                child: Text('Not finished projects first'),
              ),
              const PopupMenuItem(
                value: 'Oldest Items First',
                child: Text('Oldest Items First'),
              ),
              const PopupMenuItem(
                value: 'Newest Items First',
                child: Text('Newest Items First'),
              ),
              const PopupMenuItem(
                value: 'Sort by Remaining Value: Low to High',
                child: Text('Sort by Remaining Value: Low to High'),
              ),
              const PopupMenuItem(
                value: 'Sort by Remaining Value: High to Low',
                child: Text('Sort by Remaining Value: High to Low'),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Display the first project in the queue
              if (sortedClothes.isNotEmpty)
                Data(
                  imageUrl: sortedClothes[currentQueueIndex].imageUrl,
                  title: sortedClothes[currentQueueIndex].title,
                  description: sortedClothes[currentQueueIndex].description,
                  projectvalue: sortedClothes[currentQueueIndex].projectvalue,
                  paidvlaue: sortedClothes[currentQueueIndex].paidvlaue,
                )
              else
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "This domain does not need donations at the moment.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Automatically show the next project when the current one is complete
  void _autoShowNextProject() {
    if (currentQueueIndex < sortedClothes.length - 1) {
      // Periodically check if the current project is complete
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          // If the current project is complete (paidvlaue >= projectvalue)
          if (sortedClothes[currentQueueIndex].paidvlaue >=
              sortedClothes[currentQueueIndex].projectvalue) {
            currentQueueIndex++; // Move to the next project automatically
          }
        });
        _autoShowNextProject(); // Continue checking for the next project
      });
    }
  }

  void _sortList(String sortOption) {
    setState(() {
      switch (sortOption) {
        case 'finished projects':
          sortedClothes = clothes.where((project) {
            return project.paidvlaue >= project.projectvalue;
          }).toList();
          break;

        case 'Not finished projects first':
          sortedClothes = clothes.where((project) {
            return project.paidvlaue < project.projectvalue;
          }).toList();
          break;

        case 'Oldest Items First':
          sortedClothes.sort((a, b) => a.date.compareTo(b.date));
          break;

        case 'Newest Items First':
          sortedClothes.sort((a, b) => b.date.compareTo(a.date));
          break;

        case 'Sort by Remaining Value: Low to High':
          sortedClothes.sort((a, b) => (a.projectvalue - a.paidvlaue)
              .compareTo(b.projectvalue - b.paidvlaue));
          break;

        case 'Sort by Remaining Value: High to Low':
          sortedClothes.sort((a, b) => (b.projectvalue - b.paidvlaue)
              .compareTo(a.projectvalue - a.paidvlaue));
          break;

        default:
          break;
      }
    });
  }
}

// // Assume the Data widget includes progress tracking
// class Data extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final double projectvalue;
//   final double paidvlaue;

//   const Data({
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.projectvalue,
//     required this.paidvlaue,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Check if the project is complete
//     bool isComplete = paidvlaue >= projectvalue;

//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(imageUrl),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(description),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: LinearProgressIndicator(
//               value: paidvlaue / projectvalue,
//               backgroundColor: Colors.grey[200],
//               color: Colors.green,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Progress: ${paidvlaue.toStringAsFixed(2)} / ${projectvalue.toStringAsFixed(2)}",
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//           if (isComplete)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: const Text('Project Complete!'),
//             ),
//         ],
//       ),
//     );
//   }
// }
