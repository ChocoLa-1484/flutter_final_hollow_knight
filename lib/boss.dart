class Boss {
  final String name;
  final String href;
  final String imgSrc;
  const Boss({required this.name, required this.href, required this.imgSrc});

  factory Boss.fromJson(Map<String, dynamic> json) {
    return Boss(
      name: json['data-title'],
      href: json['data-href'],
      imgSrc: json['data-src'],
    );
  }
}
