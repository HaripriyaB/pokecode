import 'package:flutter/material.dart';
import 'package:fluttermlh/Course.dart';
import 'package:fluttermlh/models/channel_model.dart';
import 'package:fluttermlh/models/video_model.dart';
import 'package:fluttermlh/services/services_api.dart';
import 'package:fluttermlh/video_screen.dart';

class CourseVList extends StatelessWidget {
  final Course course;

  CourseVList({Key key,@required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoList(course:course);
  }

}

class VideoList extends StatefulWidget {
  final Course course;

  VideoList({Key key,@required this.course}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CreateVideoList(course:course);
}

class CreateVideoList extends State<VideoList>{
  final Course course;

  CreateVideoList({Key key,@required this.course});

  Channel channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel(course.courseId);
  }
  _initChannel(int id) async {
    if(id == 1) {
      Channel _channel = await APIService.instance
          .fetchChannel(channelId: 'UC8butISFwT-Wl7EV0hUK0BQ');
      setState(() {
        channel = _channel;
      });
    }
    else if(id == 2) {
      Channel _channel = await APIService.instance
          .fetchChannel(channelId: 'UCkw4JCwteGrDHIsyIIKo4tQ');
      setState(() {
        channel = _channel;
      });
      }
    else if(id == 3) {
      Channel _channel = await APIService.instance
          .fetchChannel(channelId: 'UC8butISFwT-Wl7EV0hUK0BQ');
      setState(() {
        channel = _channel;
      });
      }
    else if(id == 4) {
      Channel _channel = await APIService.instance
          .fetchChannel(channelId: 'UC8butISFwT-Wl7EV0hUK0BQ');
      setState(() {
        channel = _channel;
      });
      }
    else {
      Channel _channel = await APIService.instance
          .fetchChannel(channelId: 'UC8butISFwT-Wl7EV0hUK0BQ');
      setState(() {
        channel = _channel;
      });
      }

  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: channel.uploadPlaylistId);
    List<Video> allVideos = channel.videos..addAll(moreVideos);
    setState(() {
      channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: channel != null
          ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
          if (!_isLoading &&
              channel.videos.length != int.parse(channel.videoCount) &&
              scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
            _loadMoreVideos();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            Video video = channel.videos[index];
            return _buildVideo(video);
          },
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme
                .of(context)
                .primaryColor, // Red
          ),
        ),
      ),
    );
  }
}