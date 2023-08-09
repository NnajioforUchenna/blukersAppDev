String getTimeAgo(String dateCreated) {
  if (dateCreated == null || dateCreated.isEmpty) {
    return "Date not provided";
  }

  DateTime createdDate;
  try {
    createdDate = DateTime.parse(
        DateTime.fromMillisecondsSinceEpoch(int.parse(dateCreated)).toString());
  } catch (e) {
    return "Invalid date format";
  }

  final now = DateTime.now();
  final difference = now.difference(createdDate);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return "$years year${years > 1 ? 's' : ''} ago";
  }

  if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return "$months month${months > 1 ? 's' : ''} ago";
  }

  if (difference.inDays > 0) {
    return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
  }

  if (difference.inMinutes < 1) {
    return "just now";
  }

  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
  }

  return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
}
