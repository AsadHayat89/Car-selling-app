import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
class agreementPDF extends StatefulWidget {
  const agreementPDF({Key? key}) : super(key: key);

  @override
  State<agreementPDF> createState() => _PdfViewState();
}

class _PdfViewState extends State<agreementPDF> with WidgetsBindingObserver{
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  String pathPDF="";

  @override
  void initState() {
    super.initState();
    print("aya ho");
    fromAsset('assets/Vehicle-Salee-Agreement.pdf', 'Vehicle-Salee-Agreement.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }


  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      print("foudn here:");
      var dir = await getApplicationDocumentsDirectory();
      print("data here:"+dir.path);
      File file = File("${dir.path}/$filename");
      print(file.path);
      var data = await rootBundle.load(asset);
      print(file.path);
      var bytes = data.buffer.asUint8List();
      print(file.path);
      await file.writeAsBytes(bytes, flush: true);
      print(file.path);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width : MediaQuery. of(context). size. width ,
      height : MediaQuery. of(context). size. height,
      child: PDFView(
        filePath: '/data/user/0/com.example.mjcars/app_flutter/Vehicle-Salee-Agreement.pdf',
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onRender: (_pages) {
          setState(() {
            pages = _pages;
            isReady = true;
          });
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          _controller.complete(pdfViewController);
        },

      ),
    );
  }
}
