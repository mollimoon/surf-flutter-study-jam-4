class Prediction {
  final String title;

  const Prediction({
    required this.title,

  });

  static Prediction fromJson(Map<String, dynamic> json) {
    return Prediction( //объект
      title: json['reading'] as String,
    );
  }
}