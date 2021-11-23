SELECT cp.code 'Local',
       cp.description 'Local Contrato',
       frt.expiration_date 'Data de Vencimento',
       fpt.title 'ID_Título',
       pp.name 'Forncedor',
       fpt.complement 'Complemento_Titulo',
       fn.title 'Natureza Financeira',
       frt.title_amount 'Valor_Original',
       p.id 'Código',
       p.name Cliente,
       i.issue_date 'Emissao_Nota',
       frr.receipt_date 'Data Recebimento',
       fo.title 'Operação',
       p.city 'Cidade',
       frt.original_expiration_date 'Data de Vencimento Original',
       p.tx_id Documento,
       frr.complement 'Complemento Pagamento',
        -- frt.competence 'Competencia',
       fn.title 'Natureza Financeira',
       CASE
           WHEN frt.balance > 0 THEN 'Não'
           WHEN frt.balance = 0 THEN 'Sim'
           else 'nao_se_aplica'
       END AS 'Titulo Pago',
       #frr.fine_amount 'Multa_Aplicada',
       #frr.increase_amount 'Juros_Aplicado',
       #frr.discount_value 'Desconto_aplicado',
       #frr.total_amount 'Valor_recebido',
       #frr.receipt_date 'Data de Entrada(pgto)',
       cp.description 'Empresa_emissora_titulo',
       CASE p.type_tx_id
           WHEN 2 THEN 'PF'
           WHEN 1 THEN 'PJ'
       END 'Tipo Documento',
       frt.title 'ID_titulo'
    FROM financial_receivable_titles frt
    LEFT JOIN financial_receipt_titles frr ON frt.id = frr.financial_receivable_title_id AND frt.deleted = 0
    LEFT JOIN financers_natures fn ON frt.financer_nature_id = fn.id
    JOIN companies_places cp ON frt.company_place_id = cp.id
    LEFT JOIN people p ON frt.client_id = p.id
    JOIN financial_operations fo ON frt.financial_operation_id = fo.id
    LEFT JOIN invoice_notes i ON frt.invoice_note_id = i.id
    left join financial_payable_titles fpt on i.id = fpt.invoice_note_id
    left JOIN people pp ON fpt.supplier_id = pp.id
    WHERE frt.id IN (
        SELECT DISTINCT(frt_f.id) FROM financial_receivable_titles frt_c
            JOIN financial_receivable_titles frt_f ON frt_c.bill_title_id = frt_f.id
        )
    AND frt.deleted = 0
     -- and frt.expiration_date BETWEEN '2021-09-23' AND '2027-12-31'
    AND frt.type = 2 #Definitivo
    AND frt.bill_title_id IS NULL
    AND frt.finished = 0
    AND frt.entry_date <= '2020-01-31'
    AND frr.receipt_date > '2020-02-01'
    ORDER BY p.name;







SELECT
        cp.code'Local',
        cp.description'Empresa',
        DATE_FORMAT(fpt.expiration_date, '%d/%m/%y')'Data de Vencimento',
        fpt.title 'ID_Título',
        p.name 'Nome_Fornecedor',
        fpt.complement 'Complemento_Titulo',
        fn.title 'Natureza_Financeira',
        fpt.title_amount 'Valor Original',
        fpt.balance'Saldo',
        p.city 'Cidade',
        p.tx_id 'CPF_CNPJ',
        0'Data de Pagemento',
         -- f.payment_date 'Data_Pagamento',
        0 'Competencia_Pagamento',
        0 'Valor_total_Pago',
        f.discount_value 'Desconto_Aplicado',
        f.increase_amount 'Acrescimo_Aplicado'
     FROM  financial_paid_titles f
     LEFT JOIN financial_payable_titles fpt  ON fpt.id = f.financial_payable_title_id AND f.deleted = 0
     LEFT JOIN financers_natures fn ON fpt.financer_nature_id = fn.id
     LEFT JOIN bank_accounts ba ON f.bank_account_id = ba.id
     LEFT JOIN banks b ON b.id = ba.bank_id
     LEFT JOIN companies_places cp ON cp.id = fpt.company_place_id
     LEFT JOIN financial_divide_cost_center_previsions fdccp ON fpt.id = fdccp.financial_payable_title_id
     LEFT JOIN financial_cost_centers fcc ON fdccp.financial_cost_center_id = fcc.id
     left JOIN people p ON fpt.supplier_id = p.id
     LEFT JOIN invoice_notes i ON fpt.invoice_note_id = i.id
     WHERE fpt.created <= '2020-12-31'
     AND f.payment_date > '2021-01-01'
      -- GROUP BY fpt.id;
