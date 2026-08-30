enum UserRole { educando, educador, gestao }

extension UserRolePresentation on UserRole {
  String get label {
    return switch (this) {
      UserRole.educando => 'Educando',
      UserRole.educador => 'Educador',
      UserRole.gestao => 'Gestão',
    };
  }

  String get description {
    return switch (this) {
      UserRole.educando => 'Acompanha pontos, missões e presença.',
      UserRole.educador => 'Monitora uma turma e gera intervenções.',
      UserRole.gestao => 'Visualiza indicadores consolidados.',
    };
  }

  String get homePath {
    return switch (this) {
      UserRole.educando => '/educando/home',
      UserRole.educador => '/educador/dashboard',
      UserRole.gestao => '/gestao/overview',
    };
  }
}
