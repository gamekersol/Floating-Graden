import '../models/shopItem.dart';
import '../data/seedItems.dart' as seeds;
export '../models/shopItem.dart';

var bagOfSpring = PackItem(
  name: "Bag of Spring", 
  imagePath: 'assets/images/seedpacks/Default-pack.svg',
  dropItems: [
    seeds.seedOfCogongrass,
    seeds.seedOfUtrica,
    seeds.seedOfVeronika,
    seeds.pickMeDiamond,
  ],
  cost: 15,
);
var bagOfDiamonds = PackItem(
  name: "Shiny pack", 
  imagePath: 'assets/images/seedpacks/Diamond-pack.svg',
  dropItems: [
    seeds.seedOfVeronika,
    seeds.pickMeDiamond,
  ],
  type: .diamonds,
  cost: 3,
);

List<ShopItem> shopItems = [
  bagOfSpring,
  bagOfDiamonds,
];