class Species{
  final String name;
  final List<Duration> stages;
  final int collectStage;
  final int price;

  const Species({
    required this.name,
    required this.stages,
    required this.price,
    int? collectStage,
    }) : collectStage = stages.length;

  String getGrowTime(){
    Duration dur = Duration.zero;
    for(var stage in stages) dur += stage;
    return '${dur.inMinutes}m ${dur.inSeconds % 60}s';
  }
}