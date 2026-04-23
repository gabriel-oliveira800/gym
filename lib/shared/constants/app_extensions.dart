extension StringExtensions on String {
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String normalizeStr() {
    const accents = 'àáâãäåèéêëìíîïòóôõöùúûüýñç';
    const normals = 'aaaaaaeeeeiiiioooooouuuuync';

    var result = toLowerCase();
    for (var i = 0; i < accents.length; i++) {
      result = result.replaceAll(accents[i], normals[i]);
    }
    return result.replaceAll(' ', '-');
  }
}
