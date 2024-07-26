import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StorageListPage extends StatefulWidget {
  final String folderPath;

  StorageListPage({this.folderPath = '/'});

  @override
  _StorageListPageState createState() => _StorageListPageState();
}

class _StorageListPageState extends State<StorageListPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<Reference> _folders = [];
  List<Reference> _files = [];
  Map<String, String> _fileUrls = {}; // Store file URLs

  @override
  void initState() {
    super.initState();
    _listItems();
  }

  Future<void> _listItems() async {
    try {
      final ListResult result = await _storage.ref(widget.folderPath).listAll();

      // Debugging information
      print('Listing items in: ${widget.folderPath}');
      print('All Folders:');
      result.prefixes.forEach((folder) {
        print(folder.fullPath);
      });

      print('Files:');
      result.items.forEach((file) {
        print(file.fullPath);
      });

      // Retrieve download URLs for files
      for (Reference file in result.items) {
        final String url = await file.getDownloadURL();
        _fileUrls[file.name] = url;
        print('File: ${file.name}, URL: $url');
      }

      setState(() {
        // Remove the "pyment" folder from the list
        _folders = result.prefixes
            .where((folder) => folder.name.toLowerCase() != 'pyment')
            .toList();
        _files = result.items; // Optionally, display files if needed
      });
    } catch (e) {
      print('Error listing items: $e');
    }
  }

  void _openFolder(Reference folder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StorageListPage(folderPath: folder.fullPath),
      ),
    );
  }

  void _playVideo(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(videoUrl: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage Items'),
      ),
      body: ListView(
        children: [
          // Conditionally render ListTile for folders excluding "pyment"
          if (_folders.isNotEmpty) ...[
            ..._folders.map((folder) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _openFolder(folder);
                      },
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "COURSE",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${folder.name}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ] else ...[
           // Center(child: Text('No folders found')),
          ],
          // Optionally display files
          ..._files.map((file) => ListTile(
            leading: Icon(Icons.file_present),
            title: Text(file.name),
           //  subtitle: Text(_fileUrls[file.name] ?? 'Fetching URL...'),
            onTap: () {
              if (_fileUrls[file.name] != null) {
                _playVideo(_fileUrls[file.name]!);
              }
            },
          )),
        ],
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
