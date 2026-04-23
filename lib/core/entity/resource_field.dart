typedef ResourceFields = List<ResourceField>;

class ResourceField {
  final String id;
  final String name;
  final String gifPath;
  final String previewPath;
  final String segment;

  const ResourceField({
    required this.id,
    required this.name,
    required this.gifPath,
    required this.previewPath,
    required this.segment,
  });
}
