import 'entity.dart';

class Document<E extends Entity> {
  Document({this.id, this.entity});
  String id;
  E entity;
}
