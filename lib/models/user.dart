import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

// User Reference
class UserRef extends DocumentRef<User, UserDoc> {
  const UserRef({
    @required DocumentReference ref,
    @required DocumentDecoder<UserDoc> decoder,
    @required EntityEncoder<User> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );
}

class UserDoc extends Document<User> {
  const UserDoc(String id, User entity) : super(id, entity);

  UserDoc.fromFirebaseUser(FirebaseUser user)
      : super(
            user.uid,
            User(
              name: user.displayName,
              profileURL: user.photoUrl,
            ));
}

class User extends Entity {
  User(
      {@required this.name,
      @required this.profileURL,
      DateTime createdAt,
      DateTime updatedAt})
      : super(createdAt: createdAt, updatedAt: updatedAt);

  User.fromJson(Map<String, dynamic> json)
      : this(
            name: json[UserField.name] as String,
            profileURL: json[UserField.profileURL] as String,
            createdAt: parseCreatedAt(json),
            updatedAt: parseUpdatedAt(json));

  Map<String, dynamic> toJson() => <String, dynamic>{
        UserField.name: name,
        UserField.profileURL: profileURL,
        ...timestampJson,
      };

  final String name;
  final String profileURL;
}

class UserField {
  static const name = 'name';
  static const profileURL = 'profileURL';
}

class UsersRef extends CollectionRef<User, UserDoc> {
  UsersRef.ref()
      : super(
          ref: firestoreInstance.collection(collection),
          decoder: UserDocDecoder(),
          encoder: UserEncoder(),
        );

  static const collection = 'users';

  @override
  UserRef docRef([String id]) {
    return UserRef(
      ref: docRefRaw(id),
      encoder: encoder,
      decoder: decoder,
    );
  }
}

class UserDocDecoder extends DocumentDecoder<UserDoc> {
  @override
  UserDoc decode(DocumentSnapshot snapshot) {
    return UserDoc(
      snapshot.documentID,
      User.fromJson(FirRefDocumentSnapshotEx(snapshot).data),
    );
  }
}

class UserEncoder extends EntityEncoder<User> {
  @override
  Map<String, dynamic> encode(User entity) => entity.toJson();
}
