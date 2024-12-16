import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../navigation/pancake.dart';

class LearningPage extends StatelessWidget {
  LearningPage({Key? key}) : super(key: key);

  // Video list with titles and video IDs
  final List<Map<String, String>> _videos = [
    {'title': 'How to Ace Your Job Interview', 'id': 'mmQcX6HpCGs'},
    {'title': 'How to Find a Tech Job in 2024', 'id': 'fOnUAAUXC1E'},
    {'title': 'Top Tech Trends', 'id': 'vyQv563Y-fk'},
  ];

  // Function to share video details
  void _shareVideo(String videoTitle, String videoId) {
    Share.share(
      'Check out this video: $videoTitle\n\nWatch it here: https://www.youtube.com/watch?v=$videoId',
      subject: 'Video Recommendation: $videoTitle',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Tech Career Videos',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          PancakeMenuButton(),
        ],
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the VideoPlayerPage when the card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(
                            videoId: _videos[index]['id']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail image at the top
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            child: Image.network(
                              'https://img.youtube.com/vi/${_videos[index]['id']}/0.jpg',
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Title beneath the thumbnail
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _videos[index]['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Share button at the bottom
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  color: Colors.blue, // Set share button color to blue
                                  onPressed: () {
                                    _shareVideo(
                                      _videos[index]['title']!,
                                      _videos[index]['id']!,
                                    );
                                  },
                                ),
                                const Text('Share'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(() {
      if (_controller.value.isReady) {
        print('Video is ready to play');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
          },
        ),
      ),
    );
  }
}

