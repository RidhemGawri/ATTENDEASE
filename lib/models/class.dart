class Class {
  final String name;
  final String subject;
  final String instructor;

  Class({
    required this.name,
    required this.subject,
    required this.instructor,
  });
}

class Student {
  final String name;
  bool isPresent;

  Student({required this.name, required this.isPresent});
}

class myRecord {
  final String subject;
  final int presentCount;

  myRecord({
    required this.subject,
    required this.presentCount,
  });
}
