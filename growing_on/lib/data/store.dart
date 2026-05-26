import '../models/shopItem.dart';
import '../data/seedItems.dart' as seeds;
export '../models/shopItem.dart';

Item bagOfSpring = Item(
  name: "Bag of Spring", 
  imagePath: 'assets/images/seedpacks/Default-pack.svg'
);
List<ShopItem> shopItems = [
  PackItem(
    item: bagOfSpring,
    dropItems: [
      seeds.seedOfCogongrass,
      seeds.seedOfUtrica,
      seeds.seedOfVeronika,
      seeds.pickMeDiamond,
    ],
    cost: 1,
  ),
  // ShopItem(
  //   item: bagOfSpring,
  //   cost: 2,
  // ),
];