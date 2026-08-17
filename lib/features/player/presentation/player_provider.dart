import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/models/story_model.dart';

class PlayerState {
  final Story? currentStory;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double speed;
  final Duration? sleepTimerRemaining; // Tiempo restante del temporizador

  const PlayerState({
    this.currentStory,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.speed = 1.0,
    this.sleepTimerRemaining,
  });

  PlayerState copyWith({
    Story? currentStory,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    double? speed,
    Duration? Function()? sleepTimerRemaining,
  }) {
    return PlayerState(
      currentStory: currentStory ?? this.currentStory,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      speed: speed ?? this.speed,
      sleepTimerRemaining: sleepTimerRemaining != null
          ? sleepTimerRemaining()
          : this.sleepTimerRemaining,
    );
  }
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _sleepTimer;

  PlayerNotifier() : super(const PlayerState()) {
    _initListeners();
  }

  void _initListeners() {
    _audioPlayer.playerStateStream.listen((playerState) {
      state = state.copyWith(isPlaying: playerState.playing);
    });

    _audioPlayer.positionStream.listen((pos) {
      state = state.copyWith(position: pos);
    });

    _audioPlayer.durationStream.listen((dur) {
      if (dur != null) {
        state = state.copyWith(duration: dur);
      }
    });
  }

  Future<void> playStory(Story story) async {
    state = state.copyWith(currentStory: story);

    if (story.audioUrl.startsWith('assets/')) {
      await _audioPlayer.setAsset(story.audioUrl);
    } else {
      await _audioPlayer.setUrl(story.audioUrl);
    }

    _audioPlayer.play();
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void setSpeed(double speed) {
    _audioPlayer.setSpeed(speed);
    state = state.copyWith(speed: speed);
  }

  // --- LÓGICA DEL TEMPORIZADOR DE APAGADO ---

  void setSleepTimer(Duration duration) {
    cancelSleepTimer();

    state = state.copyWith(sleepTimerRemaining: () => duration);

    _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.sleepTimerRemaining;

      if (remaining == null || remaining.inSeconds <= 1) {
        _audioPlayer.pause();
        cancelSleepTimer();
      } else {
        state = state.copyWith(
          sleepTimerRemaining: () => remaining - const Duration(seconds: 1),
        );
      }
    });
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    state = state.copyWith(sleepTimerRemaining: () => null);
  }

  @override
  void dispose() {
    _sleepTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>((ref) {
  return PlayerNotifier();
});