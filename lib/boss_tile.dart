import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'boss.dart';

class BossTile extends StatelessWidget {
  final Boss boss;
  const BossTile({super.key, required this.boss});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // 卡片陰影
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 圓角設定
      ),
      child: InkWell(
        splashColor: Colors.grey.withAlpha(30),
        onTap: () async {
          Uri uri = Uri.parse(boss.href);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            throw 'Could not launch $boss.href';
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  boss.imgSrc,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                boss.name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
