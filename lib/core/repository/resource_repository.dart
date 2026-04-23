import '../../shared/index.dart';
import '../failure/failure.dart';
import '../entity/result.dart';

class ResourceRepository {
  List<ResourceField> all() => resources;

  Result<ResourceField> findById(String id) {
    try {
      final match = resources.firstWhere((it) => it.id == id);
      return Result.success(match);
    } catch (_) {
      return const Result.failure(
        NotFoundFailure('Recurso não encontrado'),
      );
    }
  }

  ResourceField? findByIdOrNull(String id) {
    return findById(id).getValueOrNull();
  }

  List<ResourceField> search(String segment) {
    final normalized = segment.normalizeStr();
    return resources.where((it) {
      return it.segment.contains(normalized) ||
          it.id.contains(normalized) ||
          it.name.toLowerCase().contains(normalized);
    }).toList();
  }
}
