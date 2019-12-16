import 'entity.dart';

class Document<E extends Entity> {
  String id;
  E entity;
}
