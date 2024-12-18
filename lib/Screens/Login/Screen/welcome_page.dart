import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/Screens/Login/components/clipper.dart';
import 'package:sadqahzakat/Screens/Login/components/const.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _balloonController;
  late Animation<double> balloonAnime;
  // late CustomAnimationControl _routAnimationController;

  @override
  void initState() {
    _balloonController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    balloonAnime = Tween(begin: 220.0, end: 240.0).animate(_balloonController);
    _balloonController.repeat(reverse: true);
    // _routAnimationController = CustomAnimationControl.play;
    super.initState();
  }

  @override
  void dispose() {
    _balloonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 300,
                width: width,
                color: primaryColor.withOpacity(0.3),
              ),
            ),
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width - 50,
                color: primaryColor,
              ),
            ),
            Positioned(
              width: width,
              top: 120,
              child: const Column(
                children: [
                  // RoutAnimation(
                  //   _routAnimationController,
                  //   0.0,
                    Text("Welcome!",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                  // ),
                  SizedBox(height: 10),
                  // RoutAnimation(
                  //   _routAnimationController,
                  //   0.6,
                    Text("Sign in or create a new account",
                        style: TextStyle(fontSize: 15, color: Colors.black26)),
                  // ),
                ],
              ),
            ),
            // RoutAnimation(
            //   _routAnimationController,
            //   0.8,
              AnimatedBuilder(
                animation: _balloonController.view,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                      offset: Offset(0, balloonAnime.value), child: child);
                },
                child: SizedBox(
                  height: width * 90 / 100,
                  child: Image.asset('assets/images/balloons.png'),
                ),
              ),
            // ),
            Positioned(
              top: 160,
              width: MediaQuery.of(context).size.width,
              // child: RoutAnimation(
              //   _routAnimationController,
              //   0.3,
               child: SizedBox(
                  width: width,
                  child: Image.asset(
                    'assets/images/cluods.png',
                    fit: BoxFit.contain,
                  ),
                ),
              // ),
            ),
            Positioned(
              bottom: 50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  // RoutAnimation(
                  //   _routAnimationController,
                  //   1.0,
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const LoginPage(),
                              transitionDuration: Duration.zero),
                        );
                      },
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: primaryColor),
                        ),
                        child: const Center(
                          child: Text("Go to Sign in",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  // ),
                  const SizedBox(height: 15),
                  // RoutAnimation(
                  //   _routAnimationController,
                  //   1.2,
                    Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No account yet?",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                          const SizedBox(width: 5),
                          Text("Sign up",
                              style:
                                  TextStyle(fontSize: 15, color: primaryColor)),
                        ],
                      ),
                    ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   playDirection() {
//     setState(() {
//       _routAnimationController =
//           _routAnimationController == CustomAnimationControl.play
//               ? CustomAnimationControl.playReverse
//               : CustomAnimationControl.play;
//     });
//   }
}
