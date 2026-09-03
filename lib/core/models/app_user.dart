import 'user_role.dart';

class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.segment,
    required this.campus,
    required this.badgeCode,
    this.learningTrack,
    this.className,
  });

  final String id;
  final String name;
  final UserRole role;
  final String email;
  final String segment;
  final String campus;
  final String badgeCode;
  final String? learningTrack;
  final String? className;
}
