class Recipe {
  final String name;
  final String description;

  const Recipe({
    required this.name,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'description': String description,
      } =>
        Recipe(
          name: name,
          description: description,
        ),
      _ => throw const FormatException('Failed to load recipe.'),
    };
  }
}
