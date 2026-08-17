String formatDuration(Duration duration, {Duration? referenceDuration}) {
  // Si se pasa referenceDuration (por ejemplo, la duración total del audio),
  // se evalúa si el audio en total supera 1 hora para mantener el formato 'hh:mm:ss'.
  final ref = referenceDuration ?? duration;
  final showHours = ref.inHours > 0;

  final hours = duration.inHours.toString().padLeft(2, '0');
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  if (showHours) {
    return '$hours:$minutes:$seconds';
  }

  return '$minutes:$seconds';
}
