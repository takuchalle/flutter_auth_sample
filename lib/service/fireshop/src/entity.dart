import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Entity {
  Entity({this.createdAt, this.updatedAt});

  Map<String, dynamic> get timestampJson => {
        if (createdAt == null)
          EntityField.createdAt: FieldValue.serverTimestamp(),
        EntityField.updatedAt: FieldValue.serverTimestamp()
      };

  final Timestamp createdAt;
  final Timestamp updatedAt;
}

class EntityField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}
