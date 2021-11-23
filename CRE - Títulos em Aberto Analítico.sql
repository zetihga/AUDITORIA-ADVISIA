 select
      cp.code 'Local',
      cp.description 'Empresa',
    p.name 'Cliente',
    CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
p.tx_id 'Documento',
    frt.title 'Titulo',
    ci.description `Plano`,
       CASE sp.service_using_type
           WHEN 1 THEN 'Avulso'
           WHEN 0 THEN 'Recorrente'
    END 'Tipo Serviço',
    frt.parcel 'Parcela',
    frt.bank_title_number 'NN',
    CASE acp.type
           WHEN 1 THEN 'Wireless'
           WHEN 2 THEN 'Fibra - Outros'
           WHEN 3 THEN 'Ponto a Ponto'
           WHEN 4 THEN 'Fibra - OLT'
       END 'Tecnologia',
    frt.complement 'Complemento',
    -- in2.document_number 'N_Documento(NF)',
    frt.entry_date 'Emissao',
    frt.expiration_date 'Vcto',
    frt.original_expiration_date 'Vcto_Original',
    frt.title_amount 'Valor Original',
    frt.title_amount - frt.balance 'Valor Pago' ,
    frt.balance 'Saldo',
         -- if (frt.expiration_date > curdate(),00.00,
      CASE
          WHEN DATEDIFF(current_date, frt.expiration_date) >= 1 THEN
      ROUND((0.02 * frt.v_final_amount),2)
   ELSE
      0.0
   END AS 'Multa',
   CASE
          WHEN DATEDIFF(current_date, frt.expiration_date) >= 1 THEN
       ROUND(((DATEDIFF(current_date,frt.expiration_date) * 0.03333) * frt.v_final_amount /100),2)
         -- current_date frt.expiration_date
            -- round(0.00033333 * frt.title_amount,4) * DATEDIFF(curdate(),frt.expiration_date)
   ELSE
      0.0
   END AS 'Juros',
        CASE
            WHEN DATEDIFF(current_date, frt.expiration_date) >= 1 THEN
        ROUND((frt.v_final_amount + (0.02 * frt.v_final_amount)) + (DATEDIFF(current_date,frt.expiration_date) * 0.03333) * frt.v_final_amount /100,2)
   ELSE frt.v_final_amount
    END AS 'Total a receber'
     from financial_receivable_titles frt
     left JOIN contracts c ON c.id = frt.contract_id
          left join people p on frt.client_id = p.id
          left join invoice_notes in2 on frt.invoice_note_id = in2.id
          left join bank_accounts ba on frt.bank_account_id = ba.id
          left join financers_natures fn ON frt.financer_nature_id = fn.id
          left join companies_places cp on ba.company_place_id = cp.id
          left join contract_items ci on c.id = ci.contract_id AND ci.is_composition = 1 AND ci.deleted = 0 AND ci.p_is_billable = 0
          left join authentication_access_points acp on c.authentication_access_point_id = acp.id
          left join service_products sp on ci.service_product_id = sp.id
 where frt.expiration_date between '2021-09-01' and '2021-09-01'
          and frt.balance > 0
           and frt.renegotiated = 0
           and frt.p_is_receivable = 1
           and frt.deleted = 0
           and frt.finished = 0
           and p.deleted = 0
           GROUP BY frt.id

