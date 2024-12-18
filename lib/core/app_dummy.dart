// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:zakat_app/model/all_category.dart';
// // import 'package:zakat_app/model/buttom-nevigation-item.dart';
// import 'package:zakat_app/model/doantion_model.dart';
// import 'package:zakat_app/model/working_model.dart';

// // List<BottomNavigationItem> bottomNavigationItems = [
// //   BottomNavigationItem(
// //     const Icon(Icons.home_outlined),
// //     const Icon(Icons.home),
// //     'Home',
// //     isSelected: true,
// //   ),
// //   BottomNavigationItem(
// //     const Icon(Icons.message_outlined),
// //     const Icon(Icons.message),
// //     'Message',
// //   ),
// //   BottomNavigationItem(
// //     const Icon(
// //       FontAwesomeIcons.handHoldingDollar,
// //     ),
// //     const Icon(FontAwesomeIcons.handHoldingDollar),
// //     'Donation',
// //   ),
// //   BottomNavigationItem(
// //     const Icon(Icons.shopping_cart_outlined),
// //     const Icon(Icons.shopping_cart),
// //     'Cart',
// //   ),
// //   BottomNavigationItem(
// //     const Icon(Icons.person_outline),
// //     const Icon(Icons.person),
// //     'Profile',
// //   )
// // ];

// const availableCategories = [
//   AllCategoryModel(
//     id: 'c1',
//     title: 'Portable House',
//     image: "Assests/images/AllCategory/tent.png",
//     // image: "Assests/images/AllCategory/file.png",
//     route: '/PortableHouse',
//   ),
//   AllCategoryModel(
//     id: 'c2',
//     title: 'Masjid Maintenance',
//     image: "Assests/images/AllCategory/masjid.png",
//     route: '/MasjidMaintenance',
//   ),
//   AllCategoryModel(
//     id: 'c3',
//     title: 'Marriage Support',
//     image: "Assests/images/AllCategory/marry.png",
//     route: '/MarriageSupport',
//   ),
//   AllCategoryModel(
//     id: 'c4',
//     title: 'Flood Relief',
//     image: "Assests/images/AllCategory/food1.png",
//     route: '/FloodRelief',
//   ),
//   AllCategoryModel(
//     id: 'c5',
//     title: 'Widow Family Support',
//     image: "Assests/images/AllCategory/widow.png",
//     route: '/WidowFamily',
//   ),
//   AllCategoryModel(
//     id: 'c6',
//     title: 'Small Business Setup',
//     image: "Assests/images/AllCategory/smallbusiness.png",
//     route: '/SmallBusinessSetup',
//   ),
//   AllCategoryModel(
//     id: 'c7',
//     title: 'Clothes',
//     image: "Assests/images/AllCategory/clothes1.png",
//     route: '/Clothes',
//   ),
//   AllCategoryModel(
//     id: 'c8',
//     title: 'Medical Bed',
//     image: "Assests/images/AllCategory/medicalbed.png",
//     route: '/MedicalBed',
//   ),
//   AllCategoryModel(
//     id: 'c9',
//     title: 'Wheel Chair',
//     image: "Assests/images/AllCategory/wheelchair.png",
//     route: '/WheelChair',
//   ),
//   AllCategoryModel(
//     id: 'c10',
//     title: 'Tree Donation',
//     image: "Assests/images/AllCategory/tree.png",
//     route: '/TreeDonation',
//   ),
//   AllCategoryModel(
//     id: 'c11',
//     title: 'Daig Donation',
//     image: "Assests/images/AllCategory/dgg.png",
//     route: '/DaigDonation',
//   ),
//   AllCategoryModel(
//     id: 'c12',
//     title: 'Meal Donation',
//     image: "Assests/images/AllCategory/meal.png",
//     route: '/MealDonation',
//   ),
//   AllCategoryModel(
//     id: 'c13',
//     title: 'Orphan Support',
//     image: "Assests/images/AllCategory/orphan.png",
//     route: '/OrphanSupport',
//   ),
//   AllCategoryModel(
//     id: 'c14',
//     title: 'Water Cooler',
//     image: "Assests/images/AllCategory/watercooler.png",
//     route: '/WaterCooler',
//   ),
//   AllCategoryModel(
//     id: 'c15',
//     title: 'Masjid Construction',
//     image: "Assests/images/AllCategory/masjidcot.png",
//     route: '/MasjidConst',
//   ),
//   AllCategoryModel(
//     id: 'c16',
//     title: 'Other',
//     image: "Assests/images/AllCategory/other.png",
//     route: '/Other',
//   ),
// ];

// // const daigcatogories = [
// //    DonateModel(
// //     id: 'a1',
// //     title: 'Ot',
// //     image: "Assests/images/AllCategory/other.png",
// //     des:"fgf",
// //     route: '/Other',
// //   ),
// // ];



// List<DoantionModel> filterNotFinishedProjects(List<DoantionModel> projects) {
//   return projects.where((project) => project.paidvlaue < project.projectvalue).toList();
// }



// final List<DoantionModel> portablehouse  = [
//   DoantionModel(
//     id: '1',
//     title: 'Portable House Donations for Displaced Families',
//     imageUrl: 'Assests/images/AllCategory/portablehouse.png',
//     description: 'We are urgently seeking donations of portable houses to provide safe and temporary shelter for families displaced by natural disasters and emergencies',
//     projectvalue: 10000,
//     paidvlaue: 0,
//     date: DateTime(2024, 9, 1),
//        position: 3,
//   ),
//     DoantionModel(
//     id: '1',
//     title: 'Portable House Donations for Displaced Families',
//     imageUrl: 'Assests/images/AllCategory/portablehouse.png',
//     description: 'We are urgently seeking donations of portable houses to provide safe and temporary shelter for families displaced by natural disasters and emergencies',
//     projectvalue: 10000,
//     paidvlaue: 3450,
//     date: DateTime(2024, 3, 1),
//        position: 2,
//   ),
//     DoantionModel(
//     id: '2',
//     title: 'Urgent Need Portable House',
//     imageUrl: 'Assests/images/DetailCategory/portable.png',
//     description: 'We are urgently seeking donations of portable houses to provide safe and temporary shelter for families displaced by natural disasters and emergencies',
//     projectvalue: 10000,
//     paidvlaue: 10000,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];
// // var  masjidmaintenance = [
// final List<DoantionModel> masjidmaintenance = [
//   DoantionModel(
//     id: '1',
//     imageUrl: 'Assests/images/DetailCategory/masjidod.png',
//     description: 'Our local masjid is in need of maintenance and repairs to ensure a safe and welcoming environment for all worshippers.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1, title: 'masjid Maintenance',
//   ),
// ];

// final List<DoantionModel> marriagesupport = [
//   DoantionModel(
//     id: '1',
//     title: 'Marriage Support Donations for Low-Income Couples',
//     imageUrl: 'Assests/images/DetailCategory/marriage.png',
//     description: 'Help us support low-income couples as they start their journey together. We are collecting donations for wedding expenses, including attire, venue costs, and essential household items.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
  
// ];


// final List<DoantionModel> floodrelief = [
//   DoantionModel(
//     id: '1',
//     title: 'Urgent Flood Relief Donations Needed',
//     imageUrl: 'Assests/images/DetailCategory/flood.png',
//     description: 'Recent floods have devastated our community, leaving many families without basic necessities. We urgently need donations of clean water, non-perishable food, hygiene products, blankets.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];


// final List<DoantionModel> widowfamily =[
//   DoantionModel(
//     id: '1',
//     title: 'Support for Widow Families in Need',
//     imageUrl: 'Assests/images/DetailCategory/widow.png',
//     description: 'Providing essential resources and financial aid to help widow families overcome challenges and achieve stability.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];


// final List<DoantionModel> clothes = [
//   DoantionModel(
//     id: '1',
//     title: 'Winter Clothes Needed for Families in Need',
//     imageUrl: 'Assests/images/DetailCategory/winter.png',
//     description: 'As winter approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2024, 9, 1),
//         position: 4,
//   ),
//     DoantionModel(
//     id: '2',
//     title: 'Winter Clothes Needed for Families in Need',
//     imageUrl: 'Assests/images/DetailCategory/flood.png',
//     description: 'As winter approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2024, 9, 1),
//         position: 3,
//   ),
//    DoantionModel(
//     id: '3',
//     title: 'Summer Clothes Needed for Families in Need',
//     imageUrl: 'Assests/images/AllCategory/wheelchair.png',
//     description: 'As Summer approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//     projectvalue: 10000,
//     paidvlaue: 1250,
//      date: DateTime(2024, 2, 1),
//         position: 2,
//   ),
//    DoantionModel(
//     id: '4',
//     title: 'Checking Clothes Needed for Families in Need',
//     imageUrl: 'Assests/images/AllCategory/medicalbed.png',
//     description: 'As Checking approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//     projectvalue: 10000,
//     paidvlaue: 10000,
//      date: DateTime(2023, 10, 1),
//         position: 1,
//   ),
// ];


// final List<DoantionModel>  medicalbed = [
//   DoantionModel(
//     id: '1',
//     title: 'Donations Needed for Medical Beds',
//     imageUrl: 'Assests/images/AllCategory/medicalbed.png',
//     description: 'We are seeking donations of medical beds to support patients in need of specialized care at home.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//        position: 1,
//      date: DateTime(2023, 9, 1),
//   ),
// ];


// final List<DoantionModel> wheelchair = [
//   DoantionModel(
//     id: '1',
//     title: 'Wheelchair Donation',
//     imageUrl: 'Assests/images/AllCategory/wheelchair.png',
//     description: 'Donate wheelchairs to enhance mobility and independence for individuals in need. Your contribution can significantly improve their quality of life.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];


// final List<DoantionModel> treedonation = [
//   DoantionModel(
//     id: '1',
//     title: 'Tree Donation for a Greener Community',
//     imageUrl: 'Assests/images/AllCategory/wheelchair.png',
//     description: 'Help us enhance our community’s environment by donating trees. Your contribution will support reforestation efforts, improve air quality, and provide shade and beauty to public spaces.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];




// final List<DoantionModel> daigdonation = [
//   DoantionModel(
//     id: '1',
//     title: 'Essential Medication Donations for Low-Income Patients',
//     imageUrl: 'Assests/images/AllCategory/daig.png',
//     description: 'We are seeking donations of essential medications to support low-income patients who cannot afford their prescriptions.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];




// final List<DoantionModel>  mealdonation = [
//   DoantionModel(
//     id: '1',
//     title: 'Meal Donation Drive for the Hungry',
//     imageUrl: 'Assests/images/AllCategory/meal.png',
//     description: 'Join our meal donation drive to help feed the hungry in our community. We are accepting non-perishable food items, fresh produce, and prepared meals. Your generous donations will provide nutritious meals to individuals and families facing food insecurity.',
//     projectvalue: 10000,
//     paidvlaue: 0,
//      date: DateTime(2023, 9, 1),
//         position: 1,
//   ),
// ];



// final List<DoantionModel> orphansupport = [
//   // DoantionModel(
//   //   id: '1',
//   //   title: 'Winter Clothes Needed for Families in Need',
//   //   imageUrl: '',
//   //   description: 'As winter approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//   //   projectvalue: 10000,
//   //   paidvlaue: 0,
//   //  date: DateTime(2023, 9, 1),
//   // ),
// ];



// final List<DoantionModel> waterCooler = [
//   // DoantionModel(
//   //   id: '1',
//   //   title: 'Winter Clothes Needed for Families in Need',
//   //   imageUrl: '',
//   //   description: 'As winter approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//   //   projectvalue: 10000,
//   //   paidvlaue: 0,
//   // ),
// ];


// final List<DoantionModel> masjidConst = [
//   // DoantionModel(
//   //   id: '1',
//   //   title: 'Winter Clothes Needed for Families in Need',
//   //   imageUrl: '',
//   //   description: 'As winter approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//   //   projectvalue: 10000,
//   //   paidvlaue: 0,
//   // ),
// ];


// final List<DoantionModel> other= [
//   // DoantionModel(
//   //   id: '1',
//   //   title: 'Winter Clothes Needed for Families in Need',
//   //   imageUrl: '',
//   //   description: 'As winter approaches, many families in our community lack the necessary warm clothing to stay comfortable and healthy.',
//   //   projectvalue: 10000,
//   //   paidvlaue: 0,
//   // ),
// ];





    import 'package:sadqahzakat/model/working_model.dart';

final List<WorkingHoursModel> workingHoursData = [
  const WorkingHoursModel(
    title: 'Head Office (Hawalli), And our branches in Al-Rawdah and Khaitan Al-Jahra and Al-Fahaheel',
    days: 'Saturday to Thursday: \n 8:00 am to 8:00 pm',
    friday: 'Friday: Holiday',
  ),
  const WorkingHoursModel(
    title: 'Sha’aban Working Hours',
    days: 'Saturday to Thursday: \n 8:00 am to 9:00 pm',
    friday: 'Friday: 1:00 pm to 9:00 pm',
  ),
  const WorkingHoursModel(
    title: 'Ramadan Working Hours',
    days: 'Saturday to Thursday: \n 10:00 am to 5:30 pm and 9:00 pm to 12:00 am',
    friday: 'Friday: 1:00 pm to 5:30 pm and 9:00 pm to 12:00 am',
  ),
  const WorkingHoursModel(
    title: 'Hajj & Adahi Working Hours',
    days: 'Saturday to Thursday: \n 8:00 am to 9:30 pm',
    friday: 'Friday: 1:00 pm to 9:30 pm',
  ),
];