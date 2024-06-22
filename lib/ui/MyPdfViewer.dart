import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pdf reader',
      home: MyPdfViewer(),
    );
  }
}

class MyPdfViewer extends StatefulWidget {
  const MyPdfViewer({Key? key}) : super(key: key);

  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  late PdfControllerPinch pdfControllerPinch;
  int totalCount = 0, currentPage = 1;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/pdfs/web_design.pdf'),
    );
  }

  @override
  void dispose() {
    pdfControllerPinch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contoh Doc PDF"),
      ),
      body: FutureBuilder<PdfDocument>(
        future: PdfDocument.openAsset('assets/pdfs/web_design.pdf'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading PDF: ${snapshot.error}'));
          } else {
            return _buildUI();
          }
        },
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total Pages: $totalCount"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text("Current Page: $currentPage"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            totalCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
