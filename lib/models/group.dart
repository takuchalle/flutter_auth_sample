import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import 'user.dart';

class GroupRef extends DocumentRef<Group, GroupDoc> {
  const GroupRef({
    @required DocumentReference ref,
    @required DocumentDecoder<GroupDoc> decoder,
    @required EntityEncoder<Group> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );

  WriteBatch bach() => firestoreInstance.batch();
}

class GroupDoc extends Document<Group> {
  const GroupDoc(String id, Group entity) : super(id, entity);

  GroupDoc.create(String id) : super(id, Group.createDefault());
}

class Group extends Entity {
  Group({@required this.name, DateTime createdAt, DateTime updatedAt})
      : super(createdAt: createdAt, updatedAt: updatedAt);

  Group.createDefault() : this(name: 'unko');

  Group.fromJson(Map<String, dynamic> json)
      : this(
          name: json[GroupField.name],
          createdAt: parseCreatedAt(json),
          updatedAt: parseUpdatedAt(json),
        );

  Map<String, dynamic> toJson() => <String, dynamic>{
        GroupField.name: name,
        ...timestampJson,
      };

  final String name;
}

class GroupField {
  static String name = 'name';
}

class GroupsRef extends CollectionRef<Group, GroupDoc> {
  GroupsRef.ref()
      : super(
          ref: firestoreInstance.collection(collection),
          decoder: _GroupDocDecoder(),
          encoder: _GroupEncoder(),
        );

  static const collection = 'groups';

  @override
  GroupRef docRef([String id]) {
    return GroupRef(
      ref: docRefRaw(id),
      encoder: encoder,
      decoder: decoder,
    );
  }
}

class MembersRef extends CollectionRef<User, UserDoc> {
  MembersRef.ref(String groupId)
      : assert(groupId != null),
        super(
          ref: firestoreInstance
              .collection('${GroupsRef.collection}/$groupId/$collection'),
          decoder: UserDocDecoder(),
          encoder: UserEncoder(),
        );

  static const collection = 'members';

  @override
  UserRef docRef([String id]) {
    return UserRef(
      ref: docRefRaw(id),
      encoder: encoder,
      decoder: decoder,
    );
  }
}

class _GroupDocDecoder extends DocumentDecoder<GroupDoc> {
  @override
  GroupDoc decode(DocumentSnapshot snapshot) {
    return GroupDoc(
      snapshot.documentID,
      Group.fromJson(FirRefDocumentSnapshotEx(snapshot).data),
    );
  }
}

class _GroupEncoder extends EntityEncoder<Group> {
  @override
  Map<String, dynamic> encode(Group entity) => entity.toJson();
}
