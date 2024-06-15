import 'package:flutter/material.dart';

import 'article.dart';

class GameIntroductionPage extends StatelessWidget {
  const GameIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ArticleRow(),
                ),
                Expanded(
                  flex: 1,
                  child: HollowKnightImage(),
                ),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              children: [
                for (int i = 1; i <= 6; i++)
                  Image.asset(
                    'assets/game_intro_img/HomeImg$i.webp',
                    fit: BoxFit.contain,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleRow extends StatelessWidget {
  const ArticleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        Article.str1,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class HollowKnightImage extends StatelessWidget {
  const HollowKnightImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        'assets/game_intro_img/Hollow_Knight.jpg',
      ),
    );
  }
}
