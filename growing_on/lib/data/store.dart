import '../models/shopItem.dart';
export '../models/shopItem.dart';

Item bagOfSpring = Item(
  name: "Sunflower seed", 
  imagePath: 'assets/images/trinckets/seed.svg'
);
List<ShopItem> shopItems = [
  PackItem(
    item: bagOfSpring,
    cost: 1,
  ),
  ShopItem(
    item: bagOfSpring,
    cost: 0,
  ),
  ShopItem(
    item: bagOfSpring,
    cost: 2,
  ),
];