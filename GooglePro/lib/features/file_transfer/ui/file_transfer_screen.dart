import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/transfer_state.dart';
import '../state/transfer_event.dart';
import '../viewmodel/transfer_bloc.dart';
import '../widget/transfer_progress_tile.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class FileTransferScreen extends StatefulWidget {
  final String deviceId;
  const FileTransferScreen({super.key, required this.deviceId});
  @override State<FileTransferScreen> createState() => _FileTransferScreenState();
}

class _FileTransferScreenState extends State<FileTransferScreen> {
  late final TransferBloc _bloc;
  @override void initState() { super.initState(); _bloc = TransferBloc(getIt())..add(const LoadTransferHistoryEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('File Transfer', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: Column(children: [
          // Send file button
          Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            Expanded(child: ElevatedButton.icon(onPressed: () => _bloc.add(PickAndSendFileEvent(widget.deviceId)), icon: const Icon(Icons.upload_file, color: Colors.black, size: 20), label: const Text('Send File', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15)), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, minimumSize: const Size(0, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
            const SizedBox(width: 10),
            Container(height: 52, width: 52, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: AppTheme.darkBorder)), padding: EdgeInsets.zero), child: const Icon(Icons.folder_open_outlined, color: AppTheme.primaryColor, size: 22))),
          ])),

          // Transfer list
          Expanded(child: BlocBuilder<TransferBloc, TransferState>(builder: (ctx, state) {
            if (state is TransferLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
            if (state is TransferLoaded) {
              if (state.transfers.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.folder_open_outlined, color: AppTheme.darkSubtext, size: 56).animate().scale(),
                const SizedBox(height: 16),
                const Text('No transfers yet', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15)),
                const SizedBox(height: 8),
                const Text('Tap "Send File" to transfer files\nto this device.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13, height: 1.5)),
              ]));
              return ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: state.transfers.length, itemBuilder: (ctx, i) => TransferProgressTile(file: state.transfers[i], onCancel: state.transfers[i].isActive ? () => _bloc.add(CancelTransferEvent(state.transfers[i].transferId)) : null).animate().fadeIn(delay: Duration(milliseconds: i * 50)));
            }
            if (state is TransferError) return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: AppTheme.errorColor)));
            return const SizedBox.shrink();
          })),
        ]),
      ),
    );
  }
}
