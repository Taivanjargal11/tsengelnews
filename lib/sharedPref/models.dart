enum Gender { FEMALE, MALE, OTHER }

enum ProgrammingLanguage { DART, JAVASCRIPT, KOTLIN, SWIFT }

class Settings {
  final String username;
  final String img;
  final Set<ProgrammingLanguage> programmingLanguages;
  final bool isEmployed;

  Settings(
      {this.username, this.img, this.programmingLanguages, this.isEmployed});
}