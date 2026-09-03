/// Rótulos de apresentação para as chaves de risco/nível usadas nos dados mock.
///
/// Os dados guardam a chave crua ('critico', 'atencao', 'baixo') para colorir
/// o [StatusBadge]; para exibição ao usuário, use este rótulo formatado.
String riskLabelPt(String raw) {
  switch (raw.toLowerCase().trim()) {
    case 'critico':
    case 'critical':
      return 'Crítico';
    case 'atencao':
    case 'attention':
      return 'Atenção';
    case 'baixo':
    case 'low':
      return 'Baixo';
    default:
      return raw;
  }
}

/// Converte a chave de risco dos dados ('critico'/'atencao'/'baixo') para o
/// id usado nas barras de filtro ('critical'/'attention'/'low').
String riskFilterId(String raw) {
  switch (raw.toLowerCase().trim()) {
    case 'critico':
    case 'critical':
      return 'critical';
    case 'atencao':
    case 'attention':
      return 'attention';
    default:
      return 'low';
  }
}
