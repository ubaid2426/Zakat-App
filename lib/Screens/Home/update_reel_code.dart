
// class ReelsSection extends StatefulWidget {
//   const ReelsSection({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ReelsSectionState createState() => _ReelsSectionState();
// }

// class _ReelsSectionState extends State<ReelsSection>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   List<Map<String, dynamic>> videoData = [];
//   List<String?> thumbnails = [];
//   bool isLoading = true;
//   Dio dio = Dio();
//   Set<String> viewedVideos = {};
//   int firstLoadedIndex = -1;
//   List<String> downloadedVideos = [];
//   late Directory videoDirectory;
//   @override
//   void initState() {
//     super.initState();
//      initApp();
//     _controller =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1))
//           ..repeat();
//     fetchVideos();
//   }

//   Future<void> initApp() async {
//     videoDirectory = await getApplicationDocumentsDirectory();
//     await _loadDownloadedVideos();
//     await _syncWithServer();
//     setState(() => isLoading = false);
//   }

//   Future<void> _loadDownloadedVideos() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedVideos = prefs.getStringList('downloadedVideos') ?? [];
//     downloadedVideos = savedVideos;
//   }

//   Future<void> _saveDownloadedVideos() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('downloadedVideos', downloadedVideos);
//   }

//   Future<void> _syncWithServer() async {
//     const String apiUrl = 'https://sadqahzakaat.com/data/videos/';
//     try {
//       final response = await dio.get(apiUrl);
//       if (response.statusCode == 200) {
//         final List<dynamic> serverVideos = response.data;

//         // Convert server video list to a local map for easier handling
//         final serverVideoUrls = serverVideos.map((video) => video['video']).toList();

//         // Download new videos
//         for (final video in serverVideos) {
//           if (!downloadedVideos.contains(video['video'])) {
//             await _downloadVideo(video['video']);
//             downloadedVideos.add(video['video']);
//           }
//         }

//         // Delete videos removed from the server
//         final toDelete = downloadedVideos.where((video) => !serverVideoUrls.contains(video)).toList();
//         for (final video in toDelete) {
//           await _deleteVideo(video);
//           downloadedVideos.remove(video);
//         }

//         // Save updated list of downloaded videos
//         await _saveDownloadedVideos();

//         // Update video data for the UI
//         setState(() {
//           videoData = serverVideos.map((item) {
//             return {
//               'url': item['video'],
//               'title': item['title'],
//             };
//           }).toList();
//         });
//       }
//     } catch (e) {
//       print("Error syncing with server: $e");
//     }
//   }

//   Future<void> _downloadVideo(String videoUrl) async {
//     final filePath = '${videoDirectory.path}/${videoUrl.split('/').last}';
//     try {
//       await dio.download("https://sadqahzakaat.com$videoUrl", filePath);
//       print("Downloaded: $filePath");
//     } catch (e) {
//       print("Error downloading video $videoUrl: $e");
//     }
//   }

//   Future<void> _deleteVideo(String videoUrl) async {
//     final filePath = '${videoDirectory.path}/${videoUrl.split('/').last}';
//     final file = File(filePath);
//     if (await file.exists()) {
//       await file.delete();
//       print("Deleted: $filePath");
//     }
//   }

//   Future<void> fetchVideos() async {
//     const String apiUrl = 'https://sadqahzakaat.com/data/videos/';
//     try {
//       final response = await dio.get(apiUrl);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         setState(() {
//           videoData = data.map((item) {
//             return {
//               'url': item[
//                   'video'], // Ensure this points to .m3u8 files on your server
//               'title': item['title'],
//             };
//           }).toList();
//         });
//         await _generateThumbnails();
//       } else {
//         throw Exception('Failed to load videos');
//       }
//     } catch (e) {
//       print("Error fetching videos: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> _generateThumbnails() async {
//     List<String?> tempThumbnails = [];
//     for (var i = 0; i < videoData.length; i++) {
//       try {
//         final thumbnail =
//             await generateThumbnailFromNetwork(videoData[i]['url']);
//         tempThumbnails.add(thumbnail);

//         if (firstLoadedIndex == -1) {
//           setState(() {
//             firstLoadedIndex = i;
//           });
//         }
//       } catch (e) {
//         print("Error generating thumbnail for ${videoData[i]['url']}: $e");
//         tempThumbnails.add(null);
//       }
//     }
//     setState(() {
//       thumbnails = tempThumbnails;
//       isLoading = false;
//     });
//   }

//   Future<String?> generateThumbnailFromNetwork(String videoUrl) async {
//     try {
//       final tempDir = await getTemporaryDirectory();
//       final filePath = '${tempDir.path}/${videoUrl.split('/').last}';
//       await dio.download("https://sadqahzakaat.com$videoUrl", filePath);

//       final destFile =
//           '${tempDir.path}/thumbnail_${videoUrl.split('/').last}.png';
//       final plugin = FcNativeVideoThumbnail();
//       final thumbnailGenerated = await plugin.getVideoThumbnail(
//         srcFile: filePath,
//         destFile: destFile,
//         width: 250,
//         height: 250,
//         quality: 75,
//       );

//       return thumbnailGenerated ? destFile : null;
//     } catch (e) {
//       print("Error downloading or generating thumbnail: $e");
//       return null;
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Color getAnimatedBorderColor(int index) {
//     if (viewedVideos.contains(videoData[index]['url'])) {
//       return Colors.grey;
//     }
//     return ColorTween(
//                 begin: const Color(0xFF33A248), end: const Color(0xFFB2EA50))
//             .evaluate(_controller) ??
//         Colors.green;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Reels Section",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF7fc23a)),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: videoData.length,
//                   itemBuilder: (context, index) {
//                     if (firstLoadedIndex != -1 &&
//                         index > firstLoadedIndex &&
//                         thumbnails[index] == null) {
//                       return const SizedBox.shrink();
//                     }

//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           viewedVideos.add(videoData[index]['url']);
//                         });
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 ReelsPage(videoUrl: videoData[index]['url']),
//                           ),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                         child: Column(
//                           children: [
//                             AnimatedBuilder(
//                               animation: _controller,
//                               builder: (context, child) {
//                                 return Container(
//                                   width: 70,
//                                   height: 70,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: getAnimatedBorderColor(index),
//                                         width: 3.0),
//                                     borderRadius: BorderRadius.circular(100.0),
//                                     image: thumbnails.isNotEmpty &&
//                                             thumbnails[index] != null
//                                         ? DecorationImage(
//                                             image: FileImage(
//                                                 File(thumbnails[index]!)),
//                                             fit: BoxFit.cover,
//                                           )
//                                         : null,
//                                   ),
//                                 );
//                               },
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               videoData[index]['title'],
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//   }
// }

// class ReelsPage extends StatelessWidget {
//   final String videoUrl;

//   const ReelsPage({super.key, required this.videoUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//             ),
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ReelVideoPlayer(videoUrl: videoUrl),
//       ),
//     );
//   }
// }

// class ReelVideoPlayer extends StatefulWidget {
//   final String videoUrl;

//   const ReelVideoPlayer({super.key, required this.videoUrl});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ReelVideoPlayerState createState() => _ReelVideoPlayerState();
// }

// class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = true;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         // ignore: deprecated_member_use
//         VideoPlayerController.network(
//             "https://sadqahzakaat.com${widget.videoUrl}")
//           ..initialize().then((_) {
//             setState(() {
//               _controller.play();
//             });
//           }).catchError((error) {
//             print("Error initializing video: $error");
//           });

//     _controller.addListener(() {
//       if (_controller.value.isInitialized &&
//           _controller.value.position >= _controller.value.duration) {
//         Navigator.pop(context); // Go back to home screen when video completes
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(widget.videoUrl);
//     return Center(
//       child: _controller.value.isInitialized
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 LinearProgressIndicator(
//                   value: _controller.value.position.inMilliseconds /
//                       _controller.value.duration.inMilliseconds,
//                 ),
//                 GestureDetector(
//                   onTap: _togglePlayPause,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       AspectRatio(
//                         aspectRatio: _controller.value.aspectRatio,
//                         child: VideoPlayer(_controller),
//                       ),
//                       if (!_isPlaying)
//                         const Icon(
//                           Icons.play_arrow,
//                           color: Colors.white,
//                           size: 80.0,
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           : const CircularProgressIndicator(),
//     );
//   }
// }