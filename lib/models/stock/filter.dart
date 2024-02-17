abstract class Filter<T> {
  Filter(this.itemsList);
  final List<T> itemsList;

  List<T> get filterItems;
}
