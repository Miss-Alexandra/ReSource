import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AudioRecorderWidget extends StatefulWidget {
  final Function(String) onRecordingComplete;
  const AudioRecorderWidget({super.key, required this.onRecordingComplete});

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  bool _isRecording = false;
  int _seconds = 0;
  Timer? _timer;
  
  void _toggleRecording() {
    setState(() {
      if (_isRecording) {
        _timer?.cancel();
        _isRecording = false;
        widget.onRecordingComplete('audio_${DateTime.now().millisecondsSinceEpoch}.m4a');
      } else {
        _seconds = 0;
        _isRecording = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() => _seconds++);
        });
      }
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleRecording,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isRecording ? AppColors.emergencyRed.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primaryBlue.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isRecording ? Icons.stop : Icons.mic,
              color: _isRecording ? AppColors.emergencyRed : AppColors.primaryBlue,
            ),
            const SizedBox(width: 8),
            if (_isRecording)
              Text(
                '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(color: AppColors.emergencyRed),
              )
            else
              Text('Запись', style: TextStyle(color: AppColors.primaryBlue)),
          ],
        ),
      ),
    );
  }
}