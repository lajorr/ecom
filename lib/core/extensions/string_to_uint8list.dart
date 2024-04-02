import 'dart:typed_data';

extension ToUint8List on String {
  Uint8List toUint8List() {
    final List<int> codeUnits = this.codeUnits;
    final Uint8List uint8List = Uint8List.fromList(codeUnits);
    (uint8List);
    return uint8List;
  }
}
