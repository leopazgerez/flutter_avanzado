class BandModel {
  String? id;
  String? name;
  int? votes;

  BandModel({
    this.id,
    this.name,
    this.votes,
  });

  factory BandModel.fromMap(Map<String,dynamic> data){
    return BandModel(
      id: data['id'],
      name: data['name'],
      votes: data['votes'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'votes': votes,
    };
  }
}
