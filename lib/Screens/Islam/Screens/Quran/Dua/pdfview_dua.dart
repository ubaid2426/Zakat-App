import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class Dua extends StatelessWidget {
  const Dua({super.key});

  @override
  Widget build(BuildContext context) {
    return const PDFViewerFromAsset(
      pdfAssetPath: 'assets/pdf/dua.pdf',
    );
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  const PDFViewerFromAsset({super.key, required this.pdfAssetPath});
  final String pdfAssetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('PDF From Asset'),
      ),
      body: PDF(
        enableSwipe: true,
        autoSpacing: false,
        pageFling: false,
        backgroundColor: Colors.grey,
        defaultPage: 1, // Attempt to set the first page
        onViewCreated: (PDFViewController pdfViewController) async {
          // Force start on the first page
          await pdfViewController.setPage(1);
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
