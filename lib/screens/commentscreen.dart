import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commentsystem/screens/commentservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final String username = "user 1";
  final String contenttype = "Video";
  final String contentid = "abc123";
  final ScrollController scrollController = ScrollController();
  String comment = "";
  // String time = DateFormat("hh:mm a").format(DateTime.now().toLocal());


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
var now = DateTime.now();
var formatterDate = DateFormat('dd/MM/yy');
var formatterTime = DateFormat('kk:mm');
String actualDate = formatterDate.format(now);
String actualTime = formatterTime.format(now);
 return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: width,
              child: Image.asset(
                "assets/image.png",
                width: double.infinity,
              )),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Comments").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                shrinkWrap: true,
                  controller: scrollController,
                  children: (snapshot.data as QuerySnapshot).docs.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    
                    return Card(
                      margin: EdgeInsets.all(8),
                        elevation: 7.0,
                        child: data["ContentID"]=="abc123"?ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data["Comment"].toString()),
                              Text(data["Time"].toString()),
                            ],
                          ),
                          subtitle: Text(data["Username"].toString()),
                        ):null);
                        
                  }).toList(),
                );
                       
                        } else {
                          return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xff7594CB),
                      backgroundColor: Color(0xff263e67),
                    ),
                  ],
                ),
                          );
                        }
                      },
                    ),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextField(
              onChanged: (value){
                setState(() {
                  comment = value;
                });
              },
              decoration: InputDecoration(
                suffixIcon:
                    GestureDetector(onTap: () {
                      print("$comment");
                addcomment(actualTime, username, contentid, contenttype, comment
                );
                print("done");
                    }, child: Icon(Icons.send)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: 'Comment...',
              ),
            ),
          ),
          // ElevatedButton(
          //     onPressed: (){
          //       print("$comment");
          //       addcomment(time);
          //       print("done");
          //     },
          //     child: Text(
          //       "Send",
          //       style: TextStyle(color: Colors.amber),
          //     )),
        ],
      ),
    );
  }
}
