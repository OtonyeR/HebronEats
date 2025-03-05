class Category {
  Category({
    this.iconUrl,
    required this.name,
  });
  final String name;
  final dynamic iconUrl;

  static List<Category> generateCategory() {
    return [
      Category(
        name: 'Fast Food',
        iconUrl: 'assets/icons/fastfood.png',
      ),
      Category(
        name: 'Drinks',
        iconUrl: 'assets/icons/drinks.png',
      ),
      Category(
        name: 'Soup',
        iconUrl: 'assets/icons/soup.png',
      ),
      Category(
        name: 'Rice & Pasta',
        iconUrl: 'assets/icons/rice.png',
      ),
      Category(
        name: 'Fruits & Veggies',
        iconUrl: 'assets/icons/fruits.png',
      ),
      Category(
        name: 'Combos',
        iconUrl: 'assets/icons/meals.png',
      ),
      Category(
        name: 'Snacks',
        iconUrl: 'assets/icons/snacks.png',
      ),
      Category(
        name: 'Dessert',
        iconUrl: 'assets/icons/dessert.png',
      ),
      Category(
        name: 'Favourites',
        iconUrl: 'assets/icons/heart.png',
      ),
    ];
  }
}
