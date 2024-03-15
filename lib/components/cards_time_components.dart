// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:hinos_clubes_brasileiros/models/time.dart';

// ignore: must_be_immutable
class CardTimeComponent extends StatelessWidget {
  Time time;
  VoidCallback onPressed;
  final bool isPlaying;
  final double progress;

  CardTimeComponent({
    Key? key,
    required this.time,
    required this.onPressed,
    required this.isPlaying,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    time.pathEscudo,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              width: 100.w,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(117, 112, 112, 112),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  time.nome,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
