-- =====================================================================
-- VIEW: vw_kpis_resumo
-- =====================================================================
-- Objetivo: view agregada com taxas de inadimplência pré-calculadas,
-- otimizada para alimentar os cards de KPI do dashboard. Construída
-- em camada sobre vw_credito_analitico, evitando repetir a lógica de
-- classificação de faixa de renda e categoria de risco.
--
-- Uso de SAFE_DIVIDE para evitar erro de divisão por zero caso algum
-- grupo apareça sem contratos.
-- =====================================================================

CREATE OR REPLACE VIEW `projeto-dados-coursera-494623.credito_risco.vw_kpis_resumo` AS
SELECT
  categoria_risco,
  cb_person_default_on_file,
  COUNT(*) AS total_contratos,
  SUM(loan_status) AS total_inadimplentes,
  ROUND(SAFE_DIVIDE(SUM(loan_status), COUNT(*)) * 100, 2) AS taxa_inadimplencia_pct
FROM `projeto-dados-coursera-494623.credito_risco.vw_credito_analitico`
GROUP BY categoria_risco, cb_person_default_on_file
ORDER BY taxa_inadimplencia_pct DESC;
