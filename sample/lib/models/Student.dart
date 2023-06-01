class Student {
  String name;
  String username;
  String college;
  String course;
  String studentNo;
  List<String> preExistingIllnesses;
  List<Map<String, dynamic>> entries;
  String status;

  Student(
      {required this.name,
      required this.username,
      required this.college,
      required this.course,
      required this.studentNo,
      required this.preExistingIllnesses,
      required this.entries,
      this.status = "Cleared"});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        name: json['name'],
        username: json['username'],
        college: json['college'],
        course: json['course'],
        studentNo: json['studentNo'],
        preExistingIllnesses: json['preExistingIllnesses'],
        entries: json['entries'],
        status: json['status']);
  }

  Map<String, dynamic> toJson(Student student) {
    return {
      'name': student.name,
      'username': student.username,
      'college': student.college,
      'course': student.course,
      'studentNo': student.studentNo,
      'preExistingIllnesses': student.preExistingIllnesses,
      'entries': student.entries,
      'status': student.status
    };
  }
}
