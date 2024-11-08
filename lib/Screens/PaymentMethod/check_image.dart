// import 'dart:io';

// void checkImageSize(File imageFile) {
//   try {
//     // Get the file size in bytes
//     int fileSizeInBytes = imageFile.lengthSync();

//     // Convert to kilobytes (KB)
//     double fileSizeInKB = fileSizeInBytes / 1024;

//     // Convert to megabytes (MB)
//     double fileSizeInMB = fileSizeInKB / 1024;

//     // Print the size in KB and MB
//     print('Image Size: ${fileSizeInKB.toStringAsFixed(2)} KB');
//     print('Image Size: ${fileSizeInMB.toStringAsFixed(2)} MB');

//     // Optionally, you can set a size limit
//     if (fileSizeInMB > 5) {
//       print('The image is too large! Please upload an image smaller than 5 MB.');
//     }
//   } catch (e) {
//     print('Error checking image size: $e');
//   }
// }
