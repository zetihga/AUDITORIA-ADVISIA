SELECT * /* fpt.supplier_id 'Código_Fornecedor',
        -- p.city 'Cidade',
        p.name 'Nome_Fornecedor',
        -- p.tx_id 'CPF_CNPJ',
        -- i.issue_date 'Emissão_Nota',
        -- i.document_number 'Numero_Nota',
       fpt.expiration_date 'Data_Vencimento',
        -- f.payment_date 'Data_Pagamento',
       fpt.competence 'Competencia_Pagamento',
       fpt.title_amount 'Valor_Total_A_Pagar',
        -- f.total_amount 'Valor_total_Pago',
        -- f.discount_value 'Desconto_Aplicado',
        -- f.increase_amount 'Acrescimo_Aplicado',
       fpt.balance 'Balanço',
        -- fdccp.amount 'Valor_Rateio',
       fpt.title 'ID_Título',
        -- ba.description 'Conta_Pagamento',
        -- b.name 'Banco',
        -- cp.description 'Empresa',
        -- fn.title 'Natureza_Financeira',
        -- fcc.title 'Centro_Custos',
       fpt.complement 'Complemento_Titulo' */
    FROM financial_payable_titles fpt
     -- LEFT JOIN financial_paid_titles f ON fpt.id = f.financial_payable_title_id AND f.deleted = 0
     -- LEFT JOIN financers_natures fn ON fpt.financer_nature_id = fn.id
     -- LEFT JOIN bank_accounts ba on f.bank_account_id = ba.id
    -- LEFT JOIN banks b on b.id = ba.bank_id
     -- LEFT JOIN companies_places cp on cp.id = f.company_place_id
     -- JOIN financial_divide_cost_center_previsions fdccp ON fpt.id = fdccp.financial_payable_title_id
     -- JOIN financial_cost_centers fcc ON fdccp.financial_cost_center_id = fcc.id
       JOIN people p ON fpt.supplier_id = p.id
     -- LEFT JOIN invoice_notes i ON fpt.invoice_note_id = i.id
    WHERE fpt.expiration_date BETWEEN '2021-05-01' AND '2021-07-31'
    AND fpt.deleted = 0
      -- and p.name like '%Banco do Brasil Sa%'
      -- and fpt.title_amount = '110.00'
     and fpt.v_final_amount > 0
           -- and fpt.situation = 1
       -- and fpt.approver_id is null


-- and f.deleted = 0
     -- and fpt.balance > 0

     -- ORDER BY p.name DESC;

