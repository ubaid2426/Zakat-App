import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
import 'package:zakat_app/model/all_category.dart';
// import 'package:zakat_app/core/app_icons.dart';
import 'package:zakat_app/model/buttom-nevigation-item.dart';

List<BottomNavigationItem> bottomNavigationItems = [
  BottomNavigationItem(
    const Icon(Icons.home_outlined),
    const Icon(Icons.home),
    'Home',
    isSelected: true,
  ),
  BottomNavigationItem(
    const Icon(Icons.message_outlined),
    const Icon(Icons.message),
    'Message',
  ),
  BottomNavigationItem(
    const Icon(
      FontAwesomeIcons.handHoldingDollar,
    ),
    const Icon(FontAwesomeIcons.handHoldingDollar),
    'Donation',
  ),
  BottomNavigationItem(
    const Icon(Icons.shopping_cart_outlined),
    const Icon(Icons.shopping_cart),
    'Cart',
  ),
  BottomNavigationItem(
    const Icon(Icons.person_outline),
    const Icon(Icons.person),
    'Profile',
  )
];

const availableCategories = [
  AllCategoryModel(
    id: 'c1',
    title: 'Portable House',
    image: "Assests/images/AllCategory/portablehouse.png",
    // image: "Assests/images/AllCategory/file.png",
    route: '/PortableHouse',
  ),
   AllCategoryModel(
    id: 'c2',
    title: 'Masjid Maintenance',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/MasjidMaintenance',
  ),
   AllCategoryModel(
    id: 'c3',
    title: 'Marriage Support',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/MarriageSupport',
  ),
   AllCategoryModel(
    id: 'c4',
    title: 'Flood Relief',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/FloodRelief',
  ),
   AllCategoryModel(
    id: 'c5',
    title: 'Widow Family Support',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/WidowFamily',
  ),
   AllCategoryModel(
    id: 'c6',
    title: 'Small Business Setup',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/SmallBusinessSetup',
  ),
   AllCategoryModel(
    id: 'c7',
    title: 'Clothes',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/Clothes',
  ),
   AllCategoryModel(
    id: 'c8',
    title: 'Medical Bed',
    image: "Assests/images/AllCategory/masjid.png",
    route: '/MedicalBed',
  ),
   AllCategoryModel(
    id: 'c9',
    title: 'Wheel Chair',
    image: "Assests/images/AllCategory/wheelchair.png",
    route: '/WheelChair',
  ),
   AllCategoryModel(
    id: 'c10',
    title: 'Tree Donation',
    image: "Assests/images/AllCategory/tree.png",
    route: '/TreeDonation',
  ),
   AllCategoryModel(
    id: 'c11',
    title: 'Daig Donation',
    image: "Assests/images/AllCategory/daig.png",
    route: '/DaigDonation',
  ),
   AllCategoryModel(
    id: 'c12',
    title: 'Meal Donation',
    image: "Assests/images/AllCategory/meal.png",
    route: '/MealDonation',
  ),
   AllCategoryModel(
    id: 'c13',
    title: 'Orphan Support',
    image: "Assests/images/AllCategory/orphan.png",
    route: '/OrphanSupport',
  ),
   AllCategoryModel(
    id: 'c14',
    title: 'Water Cooler',
    image: "Assests/images/AllCategory/watercooler.png",
    route: '/WaterCooler',
  ),
   AllCategoryModel(
    id: 'c15',
    title: 'Masjid Construction',
    image: "Assests/images/AllCategory/masjidconst.png",
    route: '/MasjidConst',
  ),
   AllCategoryModel(
    id: 'c16',
    title: 'Other',
    image: "Assests/images/AllCategory/other.png",
    route: '/Other',
  ),
];
