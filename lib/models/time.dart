import 'dart:convert';
import 'dart:core';

class Time {
  String nome;
  String pathHino;
  String pathEscudo;
  Time({
    required this.nome,
    required this.pathHino,
    required this.pathEscudo,
  });

  Time copyWith({
    String? nome,
    String? pathHino,
    String? pathEscudo,
  }) {
    return Time(
      nome: nome ?? this.nome,
      pathHino: pathHino ?? this.pathHino,
      pathEscudo: pathEscudo ?? this.pathEscudo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'pathHino': pathHino,
      'pathEscudo': pathEscudo,
    };
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      nome: map['nome'] as String,
      pathHino: map['pathHino'] as String,
      pathEscudo: map['pathEscudo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Time.fromJson(String source) =>
      Time.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Time(nome: $nome, pathHino: $pathHino, pathEscudo: $pathEscudo)';

  @override
  bool operator ==(covariant Time other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.pathHino == pathHino &&
        other.pathEscudo == pathEscudo;
  }

  @override
  int get hashCode => nome.hashCode ^ pathHino.hashCode ^ pathEscudo.hashCode;
}
