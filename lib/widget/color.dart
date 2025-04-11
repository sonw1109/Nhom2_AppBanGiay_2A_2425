import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorCirlce extends StatelessWidget {
  const ColorCirlce({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xffFFB74D),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(width: 15.w),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFAEEEEE),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(width: 15.w),

        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xffF48FB1),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }
}
