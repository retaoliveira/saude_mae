params <-
list(nome = "NOME COMPLETO", data_atualizacao = "2026-06-24", 
    frase_identificacao = "Pessoa com informacoes medicas relevantes para atendimento em urgencia.", 
    dav_existe = TRUE, dav_link = "https://SEU-LINK-SEGURO-PARA-A-DAV", 
    dav_resumo = "Existe Diretiva Antecipada de Vontade (DAV). Consulte o documento antes de decisoes clinicas nao emergenciais, sempre que possivel.", 
    contato_emergencia_1_nome = "NOME DO CONTATO 1", contato_emergencia_1_relacao = "Filha(o)", 
    contato_emergencia_1_telefone = "+55 00 00000-0000", contato_emergencia_2_nome = "NOME DO CONTATO 2", 
    contato_emergencia_2_relacao = "Outro contato", contato_emergencia_2_telefone = "+55 00 00000-0000", 
    tipo_sanguineo = "Nao informado", alergias = "Nao informado", 
    medicamentos_continuos = "Nao informado", condicoes_relevantes = "Nao informado", 
    plano_saude = "Nao informado", numero_carteirinha = "Nao informado", 
    medicos_referencia = "Nao informado", documentos_exames_link = "https://SEU-LINK-SEGURO-PARA-DOCUMENTOS", 
    observacoes = "Nao informado")

knitr::opts_chunk$set(echo = FALSE, warning = FALSE, message = FALSE)

safe_value <- function(x) {
  if (is.null(x) || length(x) == 0 || identical(x, "")) "Nao informado" else x
}

info_item <- function(label, value, urgent = FALSE) {
  class <- if (urgent) "info-item urgent" else "info-item"
  sprintf(
    '<div class="%s"><dt>%s</dt><dd>%s</dd></div>',
    class,
    label,
    safe_value(value)
  )
}

if (isTRUE(params$dav_existe)) {
  cat(sprintf(
    '<div class="alert"><h2>Atencao: ha DAV registrada</h2><p>%s</p><a class="button" href="%s" rel="noopener noreferrer">Abrir Diretiva Antecipada de Vontade</a></div>',
    safe_value(params$dav_resumo),
    safe_value(params$dav_link)
  ))
}

cat(info_item("Contato 1", paste(
  safe_value(params$contato_emergencia_1_nome),
  sprintf("(%s)", safe_value(params$contato_emergencia_1_relacao)),
  safe_value(params$contato_emergencia_1_telefone),
  sep = " - "
), urgent = TRUE))

cat(info_item("Contato 2", paste(
  safe_value(params$contato_emergencia_2_nome),
  sprintf("(%s)", safe_value(params$contato_emergencia_2_relacao)),
  safe_value(params$contato_emergencia_2_telefone),
  sep = " - "
)))

cat(info_item("Tipo sanguineo", params$tipo_sanguineo))
cat(info_item("Alergias", params$alergias, urgent = TRUE))
cat(info_item("Medicamentos continuos", params$medicamentos_continuos, urgent = TRUE))
cat(info_item("Condicoes relevantes", params$condicoes_relevantes, urgent = TRUE))

cat(info_item("Plano de saude", params$plano_saude))
cat(info_item("Carteirinha / matricula", params$numero_carteirinha))
cat(sprintf('<div class="full">%s</div>', info_item("Medicos de referencia", params$medicos_referencia)))
cat(sprintf(
  '<div class="info-item full"><dt>Documentos e exames</dt><dd><a href="%s" rel="noopener noreferrer">Abrir pasta segura</a></dd></div>',
  safe_value(params$documentos_exames_link)
))

cat(sprintf('<div class="full">%s</div>', info_item("Observacoes", params$observacoes)))
