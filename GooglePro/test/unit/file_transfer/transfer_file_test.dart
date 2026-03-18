import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/file_transfer/model/transfer_file.dart';

void main() {
  group('TransferFile', () {
    test('progress is 0 when no bytes transferred', () {
      final f = TransferFile(transferId: 't1', fileName: 'test.pdf', fileSizeBytes: 1000, mimeType: 'application/pdf', direction: TransferDirection.upload, startedAt: DateTime.now());
      expect(f.progress, 0.0);
    });
    test('progress is 0.5 at half transfer', () {
      final f = TransferFile(transferId: 't1', fileName: 'test.pdf', fileSizeBytes: 1000, mimeType: 'application/pdf', direction: TransferDirection.upload, bytesTransferred: 500, startedAt: DateTime.now());
      expect(f.progress, 0.5);
    });
    test('isComplete returns true when completed', () {
      final f = TransferFile(transferId: 't1', fileName: 'test.pdf', fileSizeBytes: 1000, mimeType: 'application/pdf', direction: TransferDirection.upload, status: TransferStatus.completed, bytesTransferred: 1000, startedAt: DateTime.now());
      expect(f.isComplete, true);
    });
    test('sizeLabel formats bytes correctly', () {
      final f = TransferFile(transferId: 't1', fileName: 'f', fileSizeBytes: 1536000, mimeType: 'application/pdf', direction: TransferDirection.upload, startedAt: DateTime.now());
      expect(f.sizeLabel, contains('MB'));
    });
  });
}
