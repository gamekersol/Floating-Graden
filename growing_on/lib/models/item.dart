class Item 
{
  final String name;
  final String description;
  final String imagePath;

  const Item({required this.name, required this.imagePath, this.description = ''});
}