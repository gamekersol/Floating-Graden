import 'package:growing_on/data/species.dart' as species;
import 'package:growing_on/models/item.dart';

final Map<String,Item> dict = {
  seedOfUtrica.name : seedOfUtrica,
  seedOfCogongrass.name : seedOfCogongrass,
  seedOfVeronika.name : seedOfVeronika,
  pickMeDiamond.name : pickMeDiamond,
  dozenSeeds.name : dozenSeeds,
};

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
  name: "Binary diamond", 
  rarity: .rare,
  imagePath: 'assets/images/items/BinaryDiamond.svg',
  type: .diamonds,
  count: 2,
  description: 'Just 2 a diamonds, you know ?'
);
var dozenSeeds = CurrencyContainer(
  name: "Three dozen seeds", 
  rarity: .uncommon,
  imagePath: 'assets/images/items/DozenOfSeeds.svg',
  type: .seeds,
  count: 36,
  description: 'No wonder what you will do with it'
);