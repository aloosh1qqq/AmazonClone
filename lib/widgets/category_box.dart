import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/utils/colors.dart';

class CategoryBox extends StatefulWidget {
  CategoryBox(
      {Key? key,
      required this.data,
      this.isSelected = true,
      this.onTap,
      this.selectedColor = Colors.deepPurpleAccent})
      : super(key: key);
  final data;
  final Color selectedColor;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: widget.isSelected ? AppColors.mainColor : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                widget.data["icon"],
                color: widget.isSelected
                    ? widget.selectedColor
                    : const Color(0xFF333333),
                width: 30,
                height: 30,
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.data["name"],
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: const TextStyle(
                color: Color(0xFF333333), fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
