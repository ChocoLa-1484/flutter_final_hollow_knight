import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  final String baseUrl = 'https://www.googleapis.com/youtube/v3';
  final String apiKey = 'AIzaSyDIdJHUnGxn61risplHwxWCHhBwhrfjSKY';
  List<dynamic> videos = [];
  final ScrollController _scrollController = ScrollController();
  String _nextPageToken = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchVideos();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchVideos({String pageToken = ''}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        '$baseUrl/search?part=snippet&q=hollow knight music&type=video&key=$apiKey&maxResults=10&pageToken=$pageToken'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        videos.addAll(data['items']);
        _nextPageToken = data['nextPageToken'] ?? '';
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchVideos(pageToken: _nextPageToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: videos.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == videos.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final video = videos[index];
          final videoId = video['id']['videoId'];
          final videoUrl =
              Uri.parse('https://www.youtube.com/watch?v=$videoId');
          final thumbnailUrl = video['snippet']['thumbnails']['default']['url'];
          final title = video['snippet']['title'];
          final viewCount = video['statistics']?['viewCount'] ?? '0';
          final publishTime = video['snippet']['publishedAt'];

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => _launchURL(videoUrl),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_formatViewCount(viewCount)} • ${_formatDate(publishTime)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _formatViewCount(String viewCount) {
    if (viewCount == '0') return 'No views';
    int count = int.parse(viewCount);
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M views';
    }
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K views';
    return '$count views';
  }

  String _formatDate(String publishTime) {
    DateTime date = DateTime.parse(publishTime);
    return '${date.year}-${date.month}-${date.day}';
  }
}
