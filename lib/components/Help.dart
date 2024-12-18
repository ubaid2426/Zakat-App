import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_mask/widget_mask.dart';

class Help extends StatelessWidget {
  const Help({super.key, required this.image});
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
          image: const AssetImage("Assests/images/screen1/cardhelp.png"),
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
