String formatTimeAgo(DateTime dateTime) {
  final duration = DateTime.now().difference(dateTime);

  if (duration.inMinutes < 1) {
    return 'just now';
  } else if (duration.inMinutes < 60) {
    return '${duration.inMinutes} min ago';
  } else if (duration.inHours < 24) {
    return '${duration.inHours} hr ago';
  } else {
    return '${duration.inDays} days ago';
  }
}
