import 'package:cloud_firestore/cloud_firestore.dart';

class Rank {
  String? title;
  int? votecount;
  String? id;

  Rank({
    required String this.title,
    required int this.votecount,
    required String this.id
  });

}

class VoteListModel {
  String? title;
  int? votecount;
  Timestamp? timestamp;
  String? id;

  VoteListModel({
    required String this.title,
    required int this.votecount,
    required Timestamp this.timestamp,
    required String this.id
  });

}