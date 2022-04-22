class CommentModel{
  String ? comment , carId , senderId;

  CommentModel({required this.comment,required this.carId,required this.senderId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    carId = json['carId'];
    senderId = json['senderId'];

  }

  Map<String , dynamic> toMap(){
    return {
      'comment':comment,
      'carId':carId,
      'senderId':senderId
    };
  }
}