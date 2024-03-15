// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:hinos_clubes_brasileiros/controllers/times_controller.dart';

// ignore: must_be_immutable
class BottomNavigatorComponent extends StatefulWidget {
  TimesController timesController;
  BottomNavigatorComponent({
    Key? key,
    required this.timesController,
  }) : super(key: key);

  @override
  State<BottomNavigatorComponent> createState() =>
      _BottomNavigatorComponentState();
}

class _BottomNavigatorComponentState extends State<BottomNavigatorComponent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 100.w,
        height: 100,
        color: Colors.transparent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 75,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: (50 + selectedIndex * 25.w) - 35,
              bottom: 30,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white12,
                        Colors.white10,
                        Colors.transparent,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment(1, 2.5),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) {
                  IconData icone = Icons.sports_soccer;
                  if (index == 0) {
                    icone = FontAwesomeIcons.trophy;
                  } else if (index == 1) {
                    icone = Icons.tour_outlined;
                  } else if (index == 2) {
                    icone = CupertinoIcons.sportscourt;
                  } else if (index == 3) {
                    icone = Icons.sports_soccer;
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        widget.timesController.carregarTimes(index);
                      });
                    },
                    child: Column(
                      children: [
                        selectedIndex == index
                            ? const SizedBox()
                            : const SizedBox(height: 10),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.all(
                            selectedIndex == index ? 15 : 0,
                          ),
                          child: Icon(
                            icone,
                            size: 36,
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) {
                      String texto = "";
                      if (index == 0) {
                        texto = "A";
                      } else if (index == 1) {
                        texto = "B";
                      } else if (index == 2) {
                        texto = "C";
                      } else if (index == 3) {
                        texto = "D";
                      }
                      return Text(
                        "Série $texto",
                        style: Theme.of(context).textTheme.labelSmall,
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
