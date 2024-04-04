import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hinos_clubes_brasileiros/components/botton_navigator_component.dart';
import 'package:hinos_clubes_brasileiros/components/cards_time_components.dart';
import 'package:hinos_clubes_brasileiros/controllers/times_controller.dart';
import 'package:hinos_clubes_brasileiros/models/banner_anuncio.dart';
import 'package:hinos_clubes_brasileiros/models/time.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';

class TimesScreen extends StatefulWidget {
  const TimesScreen({super.key});

  @override
  State<TimesScreen> createState() => _TimesScreenState();
}

class _TimesScreenState extends State<TimesScreen> {
  final timesController = Get.put(TimesController());
  RxList<Time> listTimes = RxList();

  late AudioPlayer hinoPlayer;

  RxBool tocandoHino = RxBool(false);
  RxBool hinoFinalizado = RxBool(false);

  String ultimoHino = "";

  RxDouble progresso = 0.0.obs;

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  bool isLoaded = false;

  int clickCounter = 0;

  void loadAd() {
    bannerAd = BannerAd(
      adUnitId:
          kReleaseMode ? BannerAnuncio.idBanner : BannerAnuncio.testeIdBanner,
      request: const AdRequest(),
      size: AdSize.fluid,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  void carregarAnuncioEsticado() {
    InterstitialAd.load(
        adUnitId: BannerAnuncio.testeIdEsticado,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    loadAd();
    carregarAnuncioEsticado();
    timesController.carregarTimes(0);
    hinoPlayer = AudioPlayer();

    hinoPlayer.positionStream.listen((position) {
      final Duration? duration = hinoPlayer.duration;
      if (duration != null && duration.inSeconds != 0) {
        setState(() {
          progresso.value = (position.inSeconds / duration.inSeconds) * 60;
        });
      }
    });

    hinoPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        setState(() {
          tocandoHino.value = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    hinoPlayer.dispose();
  }

  Future<void> playAudio(String audioPath) async {
    if (ultimoHino == audioPath) {
      if (tocandoHino.isTrue) {
        hinoPlayer.pause();
        tocandoHino.value = false;
        return;
      } else if (tocandoHino.isFalse && hinoFinalizado.isFalse) {
        hinoPlayer.play();
        tocandoHino.value = true;
        return;
      }
    } else {
      clickCounter++;
      if (clickCounter % 3 == 0) {
        carregarAnuncioEsticado();
        interstitialAd!.show();
      }
    }

    hinoPlayer.stop();
    //  hinoPlayer.setAsset(audioPath);
    await hinoPlayer.setFilePath(audioPath);
    hinoPlayer.play();
    tocandoHino.value = true;
    ultimoHino = audioPath;
    hinoFinalizado.value = false;
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
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      bannerAd != null
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: SafeArea(
                                child: SizedBox(
                                  width: 100.w,
                                  height: 5.h,
                                  child: AdWidget(ad: bannerAd!),
                                ),
                              ),
                            )
                          : SizedBox(height: 5.h),
                      Text(
                        "Hinos do Brasil",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        width: 100.w,
                        height: 70.h,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Obx(
                          () => GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisExtent: 200,
                            ),
                            itemCount: timesController.serieSelecionada.length,
                            itemBuilder: (context, index) {
                              return CardTimeComponent(
                                onPressed: () {
                                  playAudio(timesController
                                      .serieSelecionada[index].pathHino);
                                  timesController.selecionarTime(
                                      timesController.serieSelecionada[index]);
                                },
                                time: timesController.serieSelecionada[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => timesController.timeSelecionado.isNotEmpty
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 100.w,
                          height: 60,
                          color: Colors.black,
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(timesController
                                          .timeSelecionado.first.pathEscudo),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              SizedBox(
                                width: 75.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hino ${timesController.timeSelecionado.first.nome}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                          () => Container(
                                            height: 10,
                                            width: progresso.value.w,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(5),
                                                bottomLeft:
                                                    const Radius.circular(5),
                                                topRight: Radius.circular(
                                                    progresso >= 60 ? 5 : 0),
                                                bottomRight: Radius.circular(
                                                    progresso >= 60 ? 5 : 0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => playAudio(timesController
                                              .timeSelecionado.first.pathHino),
                                          child: Obx(
                                            () => Icon(
                                              tocandoHino.isTrue
                                                  ? Icons.play_arrow
                                                  : Icons.pause,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigatorComponent(
          timesController: timesController,
        ),
      ),
    );
  }
}
