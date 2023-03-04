class BookModel {
  int? id;
  String title;
  String author;
  String image;
  String description;

  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.description,
  });

  factory BookModel.fromJson(Map<String, dynamic> mapa) => BookModel(
        id: mapa["id"],
        title: mapa["title"],
        author: mapa["author"],
        image: mapa["image"],
        description: mapa["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "image": image,
        "description": description,
      };
}
