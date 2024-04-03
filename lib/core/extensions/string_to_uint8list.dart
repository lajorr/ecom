import 'dart:typed_data';

extension ToUint8List on String {
  Uint8List toUint8List() {
    final codeUnits = this.codeUnits;
    final uint8List = Uint8List.fromList(codeUnits);
    uint8List;
    return uint8List;
  }
}
