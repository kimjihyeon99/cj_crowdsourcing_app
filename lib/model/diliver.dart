class Diliver {
  final String date; //집배 일자
  final int SMname;//SM명
  final String subject;//품목
  final String address;//받는 분 주소

  Diliver({required this.date, required this.SMname,required this.subject, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'SMname': SMname,
      'subject' :subject,
      'address': address,
    };
  }
  factory Diliver.fromJson(Map<String, dynamic> json) {
    return Diliver(
        date: json['집배일자'] as String,
        SMname: json['SM명'] as int,
        subject: json['품목'] as String,
        address: json['받는분주소'] as String,);
  }

}