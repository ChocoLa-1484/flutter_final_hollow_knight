import 'package:flutter/material.dart';

import 'boss_list_page.dart';

class BossIntroductionPage extends StatelessWidget {
  const BossIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'BOSS 介紹',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const Expanded(child: BossListPage()),
          ],
        ),
      ),
    );
  }
}
