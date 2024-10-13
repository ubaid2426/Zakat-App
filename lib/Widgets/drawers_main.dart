import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/AboutUs/about_us.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/clothes.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/daig_donation.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/food_relief.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/marriage_support.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/masjid_const.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/masjid_maintenance.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/meal_donation.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/medical_bed.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/orphan_support.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/other.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/portable_house.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/small_business.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/tree_donation.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/water_cooler.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/wheel_chair.dart';
import 'package:zakat_app/Screens/All_Category/Group/Screen/widow_family.dart';
import 'package:zakat_app/Screens/All_Category/Individual/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
import 'package:zakat_app/Screens/ContactUs/Screens/Branches.dart';
import 'package:zakat_app/Screens/ContactUs/Screens/call_us.dart';
import 'package:zakat_app/Screens/ContactUs/Screens/work_hour.dart';
// import 'package:zakat_app/Screens/ContactUs/contact_us.dart';
import 'package:zakat_app/Screens/Gallery/gallery.dart';
import 'package:zakat_app/Screens/Home/home_main.dart';
import 'package:zakat_app/Screens/Login/Screen/sing_up.dart';
import 'package:zakat_app/Screens/Need%20Support/need_support.dart';
import 'package:zakat_app/Screens/Volunteer/volunteer.dart';
import 'package:zakat_app/Screens/What_We_DO/what_we_do.dart';
// import 'package:zakat_app/components/navigation.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 230, 226, 226),
      child: Column(
        children: [
          DrawerHeader(
            // padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
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
                          'Assests/images/screen1/10001.png'), // Adjust the image path
                      fit: BoxFit.contain, // Adjust the fit as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const ManyOption(
                  menuTitle: "Home",
                  fontawesome: FontAwesomeIcons.home,
                  navigateTo: Home(),
                ),
                // VerticalDivider(width: 500, color: Colors.red,),
                const DonationMenu(
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
                const DonationMenu(
                  menuTitle: 'Donation',
                  subOptions: [
                    "Individual Donation",
                    'Request For Donation',
                  ],
                  fontawesome: FontAwesomeIcons.donate,
                ),
                // const ManyOption(
                //   menuTitle: "All Inquiries",
                //   fontawesome: FontAwesomeIcons.envelope,
                //   navigateTo: AllCategory(),
                // ),
                const ManyOption(
                  menuTitle: "What We Do",
                  fontawesome: FontAwesomeIcons.briefcase,
                  navigateTo: DonationData(),
                ),
                ManyOption(
                  menuTitle: "Become A Volunteer",
                  fontawesome: FontAwesomeIcons.handsHelping,
                  navigateTo: Volunteer(),
                ),
                const ManyOption(
                  menuTitle: "About Us",
                  fontawesome: FontAwesomeIcons.info,
                  navigateTo: AboutUs(),
                ),
                // const ManyOption(
                //   menuTitle: "Contact",
                //   fontawesome: FontAwesomeIcons.addressBook,
                //   navigateTo: ContactUs(),
                // ),
                const DonationMenu(
                  menuTitle: 'Contact Us',
                  subOptions: [
                    "Call US",
                    'Working Hours',
                    "Branches",
                  ],
                  fontawesome: FontAwesomeIcons.donate,
                ),
                const ManyOption(
                  menuTitle: "Login",
                  fontawesome: FontAwesomeIcons.rightToBracket,
                  navigateTo: Signup(),
                ),
                const ManyOption(
                  menuTitle: "Gallery",
                  fontawesome: Icons.picture_in_picture_sharp,
                  navigateTo: Gallery(),
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
  final Widget navigateTo;
  const ManyOption({
    super.key,
    required this.menuTitle,
    required this.fontawesome,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: const Color(0xFF7fc23a),
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => navigateTo), // Navigate to the screen
        );
      },
    );
  }
}

class DonationMenu extends StatefulWidget {
  final String menuTitle;
  final List<String> subOptions;
  final IconData fontawesome;
  // bool _isExpanded = false;
  const DonationMenu({
    super.key,
    required this.menuTitle,
    required this.subOptions,
    required this.fontawesome,
  });

  @override
  State<DonationMenu> createState() => _DonationMenuState();
}

class _DonationMenuState extends State<DonationMenu> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide.none,
      ),
      showTrailingIcon: false,
      initiallyExpanded: _isExpanded,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      //  selectedColor: Color(0xFF7fc23a),

      title: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: _isExpanded
            ? const Color(0xFF7fc23a)
            : const Color.fromARGB(255, 230, 226, 226),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
               
            Icon(
              widget.fontawesome,
              //  size: 22,
              color: _isExpanded
                  ? const Color.fromARGB(255, 247, 247, 247)
                  : Color.fromARGB(255, 12, 12, 12),
            ),
            SizedBox(width: 20,),
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.menuTitle,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                      ),
                ),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: _isExpanded ? Colors.white : Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
      // Customize the background color based on the expanded state

      children: widget.subOptions.map((option) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: ListTile(
            title: Text(option),
            onTap: () {
              // Action for each sub-option
              switch (option) {
                case "Portable House":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PortableHouse(),
                    ),
                  );
                  break;
                case 'Masjid Maintenance':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MasjidMaintenance(),
                    ),
                  );
                  break;
                case 'Marriage Support':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MarriageSupport(),
                    ),
                  );
                  break;
                case 'Flood Relief':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FloodRelief(),
                    ),
                  );
                  break;
                case 'Widow Family Support':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WidowFamily(),
                    ),
                  );
                  break;
                case 'Small Business Setup':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SmallBusiness(),
                    ),
                  );
                  break;
                case 'Clothes':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Clothes(),
                    ),
                  );
                  break;
                case 'Medical Bed':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicalBed(),
                    ),
                  );
                  break;
                case 'Wheel Chair':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WheelChair(),
                    ),
                  );
                  break;
                case 'Tree Donation':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TreeDonation(),
                    ),
                  );
                  break;
                case 'Daig Donation':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaigDonation(),
                    ),
                  );
                  break;
                case 'Meal Donation':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MealDonation(),
                    ),
                  );
                  break;
                    case 'Call US':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CallUs(),
                    ),
                  );
                  break;
                    case 'Working Hours':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkingHour(),
                    ),
                  );
                  break;
                      case 'Branches':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Branches(),
                    ),
                  );
                  break;
                case 'Orphan Support':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrphanSupport(),
                    ),
                  );
                  break;
                case 'Water Cooler':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WaterCooler(),
                    ),
                  );
                  break;
                case 'MAsjid Cooler':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MasjidConst(),
                    ),
                  );
                  break;
                case 'Other':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Other(),
                    ),
                  );
                  break;
                case 'Individual Donation':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const AllCategoryIndividual(),
                    ),
                  );
                  break;
                case 'Request For Donation':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const NeedCategory(),
                    ),
                  );
                  break;
                // Add other cases for remaining options...
                default:
                  print('$option tapped');
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
