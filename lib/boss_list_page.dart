import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'boss.dart';
import 'boss_tile.dart';

class BossListPage extends StatefulWidget {
  const BossListPage({super.key});

  @override
  _BossListPageState createState() => _BossListPageState();
}

class _BossListPageState extends State<BossListPage> {
  List<Boss> bosses = [];

  @override
  void initState() {
    super.initState();
    _fetchBosses();
  }

  Future<void> _fetchBosses() async {
    final String response =
        await rootBundle.loadString('assets/boss_data.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      bosses = data.map((json) => Boss.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: (bosses.length / 4).ceil(),
      itemBuilder: (BuildContext context, int index) {
        int startIndex = index * 4;
        int endIndex = startIndex + 4;
        endIndex = endIndex > bosses.length ? bosses.length : endIndex;
        List<Boss> rowBosses = bosses.sublist(startIndex, endIndex);

        return Row(
          children: [
            for (final boss in rowBosses)
              Expanded(
                child: BossTile(boss: boss),
              )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
