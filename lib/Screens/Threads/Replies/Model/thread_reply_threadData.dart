class ThreadData {
  final String? title;
  final List<ImageData>? images;
  final String? description;
  final List<TagData>? tags;

  ThreadData({this.title, this.images, this.description, this.tags});
}

class ImageData {
  final String image;
  ImageData(this.image);
}

class TagData {
  final String name;
  TagData(this.name);
}
