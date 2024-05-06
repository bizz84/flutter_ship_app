/// A model class representing an app
class App {
  App({required this.id, required this.name});
  final int id;
  final String name;

  @override
  String toString() => 'App(id: $id, name: $name)';
}
