import 'package:flutter/material.dart';

import '../utils/app_config.dart';
import 'my_text_style.dart';

class CustomListButton extends StatelessWidget {
  const CustomListButton({
    super.key,
    this.onTap,
    this.icon,
    this.title,
  });
  final VoidCallback? onTap;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: AppConfig.kPrimaryColor),
          color: Colors.grey.shade100,

        ),
        child: Row(
          children: [
            Icon(icon, color: AppConfig.kPrimaryColor),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              title ?? '',
              style: myTextStyle(clr: AppConfig.kPrimaryColor, size: 16.0),
            )
          ],
        ),
      ),
    );
    
  }
}
