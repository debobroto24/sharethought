


String formatDateTime(DateTime datetime){
  DateTime now = DateTime.now(); 
  Duration difference = now.difference(datetime); 
  if(difference.inSeconds < 60){
    return "Just now"; 
  }else if(difference.inMinutes < 60){
    return "${difference.inMinutes} min ago";
  }else if(difference.inHours < 24){
    return "${difference.inHours} hours ago";
  }else if(difference.inDays < 30){
    return "${difference.inDays} days ago";
  }else if(difference.inDays < 365){
    int months =now.month - datetime.month + 12 * (now.year- datetime.year);
    return "$months months ago";
  }else{
    return "${now.year - datetime.year} years ago";
  }

  
}