
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void addcomment(time, String username, String contentid, String contenttype, String comment) {
    print("in");
    FirebaseFirestore.instance.collection("Comments").add({
      "Username": username,
      "Time": time,
      "Comment": comment,
      "Type": contenttype,
      "ContentID": contentid
    });
  }
