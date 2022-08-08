import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  UserModel copyWith({
    String? id,
    String? userName,
    String? email,
    String? photoUrl,
    String? bio,
    List? followers,
    List? following,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      photoUrl: json['photoUrl'] ?? "",
      bio: json['bio'] ?? "",
      followers: json[' followers'] ?? [],
      following: json['following'] ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final userModel =
        UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return userModel;
  }
}