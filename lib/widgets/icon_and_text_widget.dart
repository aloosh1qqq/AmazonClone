import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        // ignore: prefer_const_constructors
        SizedBox(
          width: 8,
        ),
        SmallText(text: text),
      ],
    );
  }
}
