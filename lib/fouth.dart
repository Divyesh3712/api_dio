
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class fourth extends StatefulWidget {
  const fourth({Key? key}) : super(key: key);

  @override
  State<fourth> createState() => _fourthState();
}

class _fourthState extends State<fourth> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData() async {
    try {
      var response = await Dio().get('https://jsonplaceholder.typicode.com/photos');
      print(response);
      l = response.data;
      setState(() {
        status = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fourth API"),
        centerTitle: true,
      ),
      body: status
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                Acess m = Acess.fromJson(l[index]);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    backgroundImage: NetworkImage("${m.url}"),
                    child: Text(
                      "${m.id}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text("Album Id:${m.albumId}\n\nTitle:${m.title}\n"),
                  subtitle: Text("Url:${m.url}\n\nThumbnaiUrl:${m.thumbnailUrl}\n"),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

// Json To Dart Class
class Acess {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Acess({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Acess.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
