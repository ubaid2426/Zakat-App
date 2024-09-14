import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainDrawer());
}

// class DrawerMain extends StatelessWidget {
//   const DrawerMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//             title: const Text("activePageTitle"),
//             ),
//         drawer: const MainDrawer(),
//       ),
//     );
//   }
// }

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 260,
                  width: 260,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'Assests/Images/10001.png'), // Adjust the image path
                      fit: BoxFit.contain, // Adjust the fit as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ManyOption(
                  menuTitle: "Home",
                  fontawesome: FontAwesomeIcons.home,
                ),
                DonationMenu(
                  menuTitle: 'Donate By Category',
                  subOptions: [
                    "Portable House",
                    'Masjid Maintenance',
                    'Marriage Support',
                    'Flood Relief',
                    'Widow Family Support',
                    'Small Business Setup',
                    'Clothes',
                    'Medical Bed',
                    'Wheel Chair',
                    'Tree Donation',
                    'Daig Donation',
                    'Meal Donation',
                    'Orphan Support',
                    'Water Cooler',
                    'Masjid Construction',
                    "Other"
                  ],
                  fontawesome: FontAwesomeIcons.layerGroup,
                ),
                DonationMenu(
                  menuTitle: 'Donation',
                  subOptions: [
                    "Individual Donation",
                    'Request For Donation',
                  ],
                  fontawesome: FontAwesomeIcons.donate,
                ),
                ManyOption(
                  menuTitle: "All Inquiries",
                  fontawesome: FontAwesomeIcons.envelope,
                ),
                ManyOption(
                  menuTitle: "What We Do",
                  fontawesome: FontAwesomeIcons.briefcase,
                ),
                ManyOption(
                  menuTitle: "Become A Volunteer",
                  fontawesome: FontAwesomeIcons.handsHelping,
                ),
                ManyOption(
                  menuTitle: "About Us",
                  fontawesome: FontAwesomeIcons.info,
                ),
                ManyOption(
                  menuTitle: "Contact",
                  fontawesome: FontAwesomeIcons.addressBook,
                ),
                ManyOption(
                  menuTitle: "Login",
                  fontawesome: FontAwesomeIcons.rightToBracket,
                ),
                ManyOption(
                  menuTitle: "Gallery",
                  fontawesome: Icons.picture_in_picture_sharp,
                ),
                // Add more options as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManyOption extends StatelessWidget {
  final String menuTitle;
  final IconData fontawesome;

  const ManyOption({
    super.key,
    required this.menuTitle,
    required this.fontawesome,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        fontawesome,
        size: 22,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        menuTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
      ),
      onTap: () {
        // Handle the tap event here
        print('$menuTitle tapped');
      },
    );
  }
}

class DonationMenu extends StatelessWidget {
  final String menuTitle;
  final List<String> subOptions;
  final IconData fontawesome;

  const DonationMenu({
    super.key,
    required this.menuTitle,
    required this.subOptions,
    required this.fontawesome,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        fontawesome,
        size: 22,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        menuTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
      ),
      children: subOptions.map((option) {
        return ListTile(
          title: Text(option),
          onTap: () {
            // Action for each sub-option
            print('$option tapped');
          },
        );
      }).toList(),
    );
  }
}
