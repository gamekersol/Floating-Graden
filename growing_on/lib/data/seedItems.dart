import 'package:growing_on/data/species.dart' as species;
import 'package:growing_on/models/item.dart';

//TODO so many imports, type of curency make as separate class
import 'currency.dart' as ineedonlytype;

var seedOfUtrica = SeedItem(
  name: "Seed of something spiky", 
  rarity: .uncommon,
  imagePath: 'assets/images/trinckets/seed.svg',
  description: 'thouse are spiky and somethimes beneficial, not only in ordinary way',
  species: species.utrica_dioica,
);
var seedOfCogongrass = SeedItem(
  name: "Seed of cogongrass", 
  rarity: .common,
  imagePath: 'assets/images/trinckets/seed.svg',
  description: 'the only fluffy thing in this place',
  species: species.cogongrass,
);
var seedOfVeronika = SeedItem(
  name: "Seed of veronika", 
  rarity: .veryrare,
  imagePath: 'assets/images/trinckets/seed.svg',
  description: 'It is so fucking beatiful',
  species: species.veronika_prostrata,
);
var pickMeDiamond = CurrencyContainer(
  name: "Diamond", 
  rarity: .rare,
  imagePath: 'assets/images/trinckets/diamond.svg',
  type: .diamonds,
  count: 2,
  description: 'Just a diamond that splits in a half, you know ? \nGot 2 with cost of 3, smart investment!'
);