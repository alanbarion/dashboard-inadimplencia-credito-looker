-- =====================================================================
-- VIEW: vw_credito_analitico
-- =====================================================================
-- Objetivo: view analítica no nível de contrato, servindo como fonte
-- principal para o dashboard no Looker Studio. Pré-calcula faixa de
-- renda e categoria de risco para permitir filtros e cruzamentos
-- interativos sem sobrecarregar a ferramenta de BI com lógica
-- condicional em tempo real.
--
-- Fonte: dataset público "Credit Risk Dataset" (Kaggle)
-- https://www.kaggle.com/datasets/laotse/credit-risk-dataset
-- =====================================================================

CREATE OR REPLACE VIEW `projeto-dados-coursera-494623.credito_risco.vw_credito_analitico` AS
SELECT
  loan_grade,
  loan_intent,
  loan_status,
  cb_person_default_on_file,
  person_income,
  CASE
    WHEN person_income < 20000 THEN '1 - Baixa (< 20k)'
    WHEN person_income < 50000 THEN '2 - Media (20k-50k)'
    WHEN person_income < 100000 THEN '3 - Alta (50k-100k)'
    ELSE '4 - Muito Alta (> 100k)'
  END AS faixa_renda,
  CASE
    WHEN loan_grade IN ('D', 'E', 'F', 'G') THEN 'Alto Risco'
    ELSE 'Risco Padrão'
  END AS categoria_risco
FROM `projeto-dados-coursera-494623.credito_risco.emprestimos`;
