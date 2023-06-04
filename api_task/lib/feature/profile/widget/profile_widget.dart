import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, required this.onTap, required this.text})
      : super(key: key);
  final GestureTapCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: blueColor,
              )
            ],
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
