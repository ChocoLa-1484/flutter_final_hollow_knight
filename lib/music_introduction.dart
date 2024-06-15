import 'package:flutter/material.dart';
import 'video_list_page.dart';

class MusicIntroductionPage extends StatelessWidget {
  const MusicIntroductionPage({super.key});

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
                  '音樂欣賞',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const Expanded(
              child: VideoListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
