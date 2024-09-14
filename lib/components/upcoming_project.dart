// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:widget_mask/widget_mask.dart';

// class UpComingProjects extends StatelessWidget {
//   const UpComingProjects({super.key, required this.image});
//  final ImageProvider image;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: SizedBox(
//               height: 400,
//               width: MediaQuery.of(context).size.width,
//               child: Stack(
//                 children: [
//                    Home(image: image,),
//                   Positioned(
//                     top: 30,
//                     right: 0,
//                     child: Stack(
//                       children: [
//                         SizedBox(
//                           height: 100,
//                           width: 120,
//                           child: SvgPicture.asset(
//                             'Assests/svg/button.svg',
//                             width: 120,
//                             height: 100,
//                             // color: Colors.white,
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Container(
//                             width: 120,
//                             height: 100,
//                             child: const Column(
//                               children: [
//                                 Text(
//                                   'May',
//                                   style: TextStyle(
//                                     fontSize: 28,
//                                     color: Color(0xFFFFFFFF),
//                                     fontFamily: "Arial",
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   '24',
//                                   style: TextStyle(
//                                     fontSize: 28,
//                                     color: Color(0xFFFFFFFF),
//                                     fontFamily: "Arial",
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   const Home({super.key, required this.image});
//   final ImageProvider image;
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: ImageFiledTextDemo(image: image,),
//     );
//   }
// }

// class ImageFiledTextDemo extends StatelessWidget {
//   const ImageFiledTextDemo({super.key, required this.image});
//   final ImageProvider image;
//   @override
//   Widget build(BuildContext context) => DemoCard(
//         child: Center(
//           child: NegativeMaskedImage(
//             mask: DemoCard(
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 400,
//                 decoration:  BoxDecoration(
//                   image: DecorationImage(
//                     image: image, // Your image path
//                     fit: BoxFit
//                         .cover, // Adjust the image to cover the entire container
//                   ),
//                 ),
//               ),
//             ),
//             image: const AssetImage("Assests/images/screen1/card.png"),
//           ),
//         ),
//       );
// }

// class NegativeMaskedImage extends StatelessWidget {
//   const NegativeMaskedImage({
//     Key? key,
//     required this.mask,
//     required this.image,
//   }) : super(key: key);

//   final Widget mask;

//   final ImageProvider image;

//   @override
//   Widget build(BuildContext context) => WidgetMask(
//         blendMode: BlendMode.srcATop,
//         childSaveLayer: true,
//         mask: mask,
//         child: Image(
//           image: image,
//           width: MediaQuery.of(context).size.width,
//           height: 400,
//           fit: BoxFit.contain,
//         ),
//       );
// }

// class DemoCard extends StatelessWidget {
//   const DemoCard({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   Widget build(BuildContext context) => ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 500),
//         child: AspectRatio(
//           aspectRatio: 1,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: child,
//           ),
//         ),
//       );
// }

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_mask/widget_mask.dart';

class UpComingMain extends StatelessWidget {
  const UpComingMain({super.key, required this.image});
  final ImageProvider image;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
          body: ImageFiledTextDemo(image: image),
        ),
  );
}

class ImageFiledTextDemo extends StatelessWidget {
  const ImageFiledTextDemo({super.key, required this.image});
  final ImageProvider image;

  @override
  Widget build(BuildContext context) => DemoCard(
        child: NegativeMaskedImage(
          mask: Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
          image: const AssetImage("Assests/images/screen1/card.png"),
        ),
      );
}

class NegativeMaskedImage extends StatelessWidget {
  const NegativeMaskedImage(
      {super.key, required this.mask, required this.image});
  final Widget mask;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) => WidgetMask(
        blendMode: BlendMode.srcATop,
        childSaveLayer: true,
        mask: mask,
        child: Image(
            image: image,
            width: MediaQuery.of(context).size.width,
            height: 400,
            fit: BoxFit.cover),
      );
}

class DemoCard extends StatelessWidget {
  const DemoCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: child,
      );
}
