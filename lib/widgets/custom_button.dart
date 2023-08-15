import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  Widget icon;
  CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: color == null ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        primary: AppColors.mainBlackColor,
      ),
    );
  }
}
