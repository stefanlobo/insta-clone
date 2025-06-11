import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:insta_clone/state/constants/firebase_collection_name.dart';
import 'package:insta_clone/state/constants/firebase_field_name.dart';
import 'package:insta_clone/state/posts/typedefs/user_id.dart';
import 'package:insta_clone/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({required UserId userId, required String displayName, required String? email}) async {
    try {
      // first check if we have this user's info from before
      final userInfo =
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionName.users)
              .where(FirebaseFieldName.userId, isEqualTo: userId)
              .limit(1)
              .get();

      // we already have this user's info
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      // we don't have this user's info from before, create a new user
      final payload = UserInfoPayload(userId: userId, displayName: displayName, email: email);
      await FirebaseFirestore.instance.collection(FirebaseCollectionName.users).add(payload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
