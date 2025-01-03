import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sadqahzakat/Screens/donation_service.dart';
import 'package:sadqahzakat/components/upcoming_project.dart';
import 'package:sadqahzakat/model/complete_project.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
        title: const Text("Our Complete Project"),
      ),
      body: const SingleChildScrollView(
        child: UpComingRender(),
      ),
    ));
  }
}

class UpComingRender extends StatefulWidget {
  const UpComingRender({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpComingRenderState createState() => _UpComingRenderState();
}

class _UpComingRenderState extends State<UpComingRender> {
  late Future<List<CompleteProject>> futureProjects;

  @override
  void initState() {
    super.initState();
    futureProjects =
        fetchProjects(); // Fetch projects when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompleteProject>>(
      future: futureProjects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No upcoming projects'));
        } else {
          List<CompleteProject> projects = snapshot.data!;

          return Column(
            children: [
              // const Text(
              //   "Our Complete Projects",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 30,
              //       fontWeight: FontWeight.w900,
              //       fontFamily: "Roboto"),
              // ),
              // const SizedBox(
              //   width: 300,
              //   child: Divider(
              //     thickness: 5,
              //     color: Color(0xFF29C77B),
              //     height: 30,
              //   ),
              // ),
              // Dynamically load each project
              for (var project in projects) ...[
                UpComingProjects(
                  image: NetworkImage(project.image),
                  text1: project.text1,
                  text2: project.text2,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 25, 15),
                  child: Text(
                    project.detail,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Roboto"),
                  ),
                ),
              ],
            ],
          );
        }
      },
    );
  }
}

class UpComingProjects extends StatelessWidget {
  const UpComingProjects(
      {super.key,
      required this.image,
      required this.text1,
      required this.text2});
  final ImageProvider image;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Scaffold(
        home: SafeArea(
          child: InkWell(
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const AllCategory()));
            // },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    UpComingMain(image: image),
                    Positioned(
                      top: 5,
                      right: 5,
                      width: 100,
                      height: 100,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              'Assests/svg/button.svg',
                              width: 100,
                              height: 90,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    text1,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        // height: 1.0,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    text2,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
