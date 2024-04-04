import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hinos_clubes_brasileiros/components/notification_snack_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool downloading = false;
  bool erro = false;
  double downloadProgress = 0.0;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  downloadAndExtract() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        downloading = true;
        downloadProgress = 0.0;
      });

      String url =
          'https://www.dropbox.com/scl/fi/983vocwkabj6uoeel2brd/assets.zip?rlkey=8by4k7k5qpl7x5dolar4acjkl&dl=0&dl=1';

      Directory tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      String zipFilePath = '$tempPath/arquivo.zip';

      http.Client client = http.Client();

      var request = http.Request('GET', Uri.parse(url));
      var responseStream = await client.send(request);

      int totalBytes = responseStream.contentLength ?? 0;
      int bytesReceived = 0;

      var file = File(zipFilePath);
      var sink = file.openWrite();

      responseStream.stream.listen(
        (List<int> chunk) {
          sink.add(chunk);
          bytesReceived += chunk.length;
          setState(() {
            downloadProgress = bytesReceived / totalBytes;
          });
        },
        onDone: () {
          sink.close();
          extractZip(zipFilePath, tempPath).then((_) {
            setState(() async {
              downloading = false;
              if (erro) {
                return;
              }
              await SharedPreferences.getInstance().then((prefs) {
                prefs.setBool('arquivos', true);
              });
              Timer(
                const Duration(seconds: 2),
                () => Get.offAllNamed("/home"),
              );
            });
          });
        },
        onError: (error) {
          setState(() {
            downloading = false;
            erro = true;
          });
          NotificationSnackbar.showError(context, "Ocorreu um erro: $error");
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      NotificationSnackbar.showError(
          context, "Verifique sua conexão com a internet");
      setState(() {
        erro = true;
      });
      return;
    }
  }

  extractZip(String zipFilePath, String destinationPath) async {
    try {
      List<int> bytes = File(zipFilePath).readAsBytesSync();
      Archive archive = ZipDecoder().decodeBytes(bytes);

      for (ArchiveFile file in archive) {
        String filePath = '$destinationPath/${file.name}';
        File outputFile = File(filePath);
        if (file.isFile) {
          List<int> data = file.content as List<int>;
          await outputFile.create(recursive: true);
          await outputFile.writeAsBytes(data);
        }
      }
    } catch (e) {
      setState(() {
        erro = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    downloadAndExtract();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.45,
                child: Image.asset(
                  "assets/images/wallpaperFutebol.jpeg",
                  fit: BoxFit.cover,
                  height: 100.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: erro
                      ? Text(
                          'Ocorreu um erro. Tente novamente mais tarde.',
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      : downloading
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  'Baixando e extraindo arquivos...',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                SizedBox(height: 2.h),
                                LinearProgressIndicator(
                                  value: downloadProgress,
                                ),
                              ],
                            )
                          : Text(
                              'Download e extração dos arquivos completos',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
