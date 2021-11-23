 select
      cp.code 'Local do Contrato',
      cpp.code 'Local da Nota',
      cp.description 'Empresa',
      cpp.description 'Empresa da Nota',
        case
		when frt2.payment_form_id = 1 then 'Dinheiro'
		when frt2.payment_form_id = 2 then 'Cheque a vista'
		when frt2.payment_form_id = 3 then 'Cheque Pré'
		when frt2.payment_form_id = 4 then 'Cartão Débito'
		when frt2.payment_form_id = 5 then 'Cartão Crédito'
		when frt2.payment_form_id = 6 then 'Crediário'
		when frt2.payment_form_id = 7 then 'Boleto'
		when frt2.payment_form_id = 8 then 'Débito'
		when frt2.payment_form_id = 9 then 'PIX'
END 'Forma de pagamento',
      p.city 'Cidade',
      ba.description 'Banco',
    p.name 'Cliente',
    CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
p.tx_id 'Documento',
    frt.title 'Titulo',
     -- ci.description `Plano`,
      --   CASE sp.service_using_type
        --    WHEN 1 THEN 'Avulso'
         --  WHEN 0 THEN 'Recorrente'
     -- END 'Tipo Serviço',
    frt.parcel 'Parcela',
    fn.title 'Natureza Financeira',
    frt.bank_title_number 'NN',
    frt2.receipt_date 'Data de Recebimento',
        case
    when frt.balance > 0 then 'ABERTO'
    when frt.balance = 0 then 'PAGO'
    end 'PAGO OU NÃO',
    frt.complement 'Complemento',
    in2.document_number 'N_Documento(NF)',
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
    END AS 'Total a receber',
    pppp.name 'Responsável'
     from financial_receivable_titles frt
     left JOIN contracts c ON c.id = frt.contract_id
          left join people p on frt.client_id = p.id
          left join invoice_notes in2 on frt.invoice_note_id = in2.id
          left join bank_accounts ba on frt.bank_account_id = ba.id
          left join financers_natures fn ON frt.financer_nature_id = fn.id
          left join companies_places cp on ba.company_place_id = cp.id
          left join companies_places cpp on cpp.id = in2.company_place_id
          left join financial_operations fo on in2.financial_operation_id = fo.id
          left join financial_receipt_titles frt2 on frt.id = frt2.financial_receivable_title_id
          left join financial_receivable_title_occurrences frto on frt.id = frto.financial_receivable_title_id
          left join people pppp on pppp.id = frto.responsible_id
 where frt2.receipt_date between '2021-10-01' and '2021-10-31'
           and frt.deleted = 0
           and frt.origin in (4,3,11)
           and fo.id in (61,35,62,32,28,64)
           and frto.financial_title_occurrence_type_id = 26






 select
      cp.code 'Local do Contrato',
      cpp.code 'Local da Nota',
      cp.description 'Empresa',
      cpp.description 'Empresa da Nota',
        case
		when frt2.payment_form_id = 1 then 'Dinheiro'
		when frt2.payment_form_id = 2 then 'Cheque a vista'
		when frt2.payment_form_id = 3 then 'Cheque Pré'
		when frt2.payment_form_id = 4 then 'Cartão Débito'
		when frt2.payment_form_id = 5 then 'Cartão Crédito'
		when frt2.payment_form_id = 6 then 'Crediário'
		when frt2.payment_form_id = 7 then 'Boleto'
		when frt2.payment_form_id = 8 then 'Débito'
		when frt2.payment_form_id = 9 then 'PIX'
END 'Forma de pagamento',
      p.city 'Cidade',
      ba.description 'Banco',
    p.name 'Cliente',
    CASE p.type_tx_id
           WHEN 2 THEN 'CPF'
           WHEN 1 THEN 'CNPJ'
       END 'Tipo Documento',
p.tx_id 'Documento',
    frt.title 'Titulo',
     -- ci.description `Plano`,
      --   CASE sp.service_using_type
        --    WHEN 1 THEN 'Avulso'
         --  WHEN 0 THEN 'Recorrente'
     -- END 'Tipo Serviço',
    frt.parcel 'Parcela',
    fn.title 'Natureza Financeira',
    frt.bank_title_number 'NN',
    frt2.receipt_date 'Data de Recebimento',
        case
    when frt.balance > 0 then 'ABERTO'
    when frt.balance = 0 then 'PAGO'
    end 'PAGO OU NÃO',
    frt.complement 'Complemento',
    in2.document_number 'N_Documento(NF)',
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
     -- pppp.name 'Responsável'
     from financial_receivable_titles frt
     left JOIN contracts c ON c.id = frt.contract_id
          left join people p on frt.client_id = p.id
          left join invoice_notes in2 on frt.invoice_note_id = in2.id
          left join bank_accounts ba on frt.bank_account_id = ba.id
          left join financers_natures fn ON frt.financer_nature_id = fn.id
          left join companies_places cp on ba.company_place_id = cp.id
          left join companies_places cpp on cpp.id = in2.company_place_id
          left join financial_operations fo on in2.financial_operation_id = fo.id
          left join financial_receipt_titles frt2 on frt.id = frt2.financial_receivable_title_id
           -- left join financial_receivable_title_occurrences frto on frt.id = frto.financial_receivable_title_id
           -- left join people pppp on pppp.id = frto.responsible_id
 where frt2.receipt_date between '2021-10-01' and '2021-10-31'
           and frt.deleted = 0
           and frt.origin in (3,4,11,8,44)
           and fo.id in (61,35,62,32,28,64)
           and frt.bank_title_number is null
           and cp.id = 2
           and cpp.id = 1
           and ba.id = 9
            -- and c.status in (1)
            -- and p.name like '%Marcia Ismael Pedrini%'

            -- 270 CAIXA CENTRAL
            -- 261 Provedor Bradesco 21620-8
            -- 78  BANCO DO BRASIL - PROVEDOR - AG 0379-4 CC 47587-4
            -- CEF - PROVEDOR - AG 3090 CC 432-8
            -- 317 - BRADESCO - WEBBY SUL - AG 3384 CC 561-4
            -- 9 - BANCO DO BRASIL - TECNOLOGIA - AG 0379-4 CC 29325-3
            -- 3 - BRADESCO - TECNOLOGIA - AG 3384 - CC 7941-3
        select * from companies_places cp where cp.description like '%Webby Tec%'
        SELECT * FROM bank_accounts ba
        where ba.description like '%BRADESCO - TECNOLOGIA%'



