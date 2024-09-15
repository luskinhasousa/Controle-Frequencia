class Aluno {
  final String id;
  final String nome;

  Aluno({required this.id, required this.nome});
}

class Turma {
  final String id;
  final String nome;
  final List<Aluno> alunos;

  Turma({required this.id, required this.nome, required this.alunos});
}

class RegistroPresenca {
  final String alunoId;
  final DateTime data;
  final bool presente;

  RegistroPresenca({required this.alunoId, required this.data, required this.presente});
}
