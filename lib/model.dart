import 'package:cloud_firestore/cloud_firestore.dart';

class Rank {
  String? title;
  int? votecount;
  String? id;
  String img;

  Rank({
    required String this.title,
    required int this.votecount,
    required String this.id,
    required String this.img,
  });
}

class VoteListModel {
  String? title;
  int? votecount;
  Timestamp? timestamp;
  String? id;

  VoteListModel(
      {required String this.title,
      required int this.votecount,
      required Timestamp this.timestamp,
      required String this.id});
}

class BoardModel {
  String? id;
  String? title;
  String? writer;
  int? replycount;
  Timestamp? ts;
  String? name;

  BoardModel({
    required String this.id,
    required String this.title,
    required String this.writer,
    required int this.replycount,
    required Timestamp this.ts,
    required String this.name,
  });
}
