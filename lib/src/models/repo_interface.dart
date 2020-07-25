abstract class IRepository<T> {
  Future<T> get(dynamic id);
  Future<void> add(T object);
}