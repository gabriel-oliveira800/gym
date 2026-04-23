String normalizeStr(String str) {
  const accents = 'àáâãäåèéêëìíîïòóôõöùúûüýñç';
  const normals = 'aaaaaaeeeeiiiioooooouuuuync';

  var result = str.toLowerCase();
  for (var i = 0; i < accents.length; i++) {
    result = result.replaceAll(accents[i], normals[i]);
  }
  return result.replaceAll(' ', '-');
}
