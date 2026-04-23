import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/constants/helpers.dart';
import '../shared/resources/resources.generated.dart';
import '../data/models/resource_field.dart';

final resourceSearchProvider =
    StateNotifierProvider<ResourceSearchNotifier, List<ResourceField>>((ref) {
  return ResourceSearchNotifier();
});

class ResourceSearchNotifier extends StateNotifier<List<ResourceField>> {
  ResourceSearchNotifier() : super([]);

  void search(String segment) {
    final normalized = normalizeStr(segment);
    state = resources
        .where((r) {
          final seg = r.segment;
          final id = r.id;
          final name = r.name;
          return seg.contains(normalized) ||
              id.contains(normalized) ||
              name.toLowerCase().contains(normalized);
        })
        .toList();
  }

  void clear() {
    state = [];
  }
}
