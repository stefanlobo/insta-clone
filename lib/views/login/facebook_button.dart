import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/views/constants/app_colors.dart';
import 'package:insta_clone/views/constants/strings.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.facebook, color: AppColors.facebookColor),
          const SizedBox(width: 10.0),
          const Text(Strings.facebook),
        ],
      ),
    );
  }
}
