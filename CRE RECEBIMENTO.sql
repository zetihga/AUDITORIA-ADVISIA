SELECT  cp.description 'Local do Contrato',
        cpp.code 'Local da Nota',
        cpp.description 'Empresa da Nota',
        ba.description 'Banco',
        frtt.title 'Título',
        p.name 'Nome',
case
		when p.type_tx_id = 2 then 'PF'
		when p.type_tx_id = 1 then 'PJ'
END 'Tipo',
p.city 'Cidade',
ba.description 'Conta',
frt.fine_amount 'Acrescimo',
frt.discount_value 'Desconto',
frt.amount 'Valor Pago',
frt.total_amount 'Valor Total',
 fo.title 'Operação Financeira',
frt.receipt_date 'Data Recebimento',
case
		when frt.payment_form_id = 1 then 'Dinheiro'
		when frt.payment_form_id = 2 then 'Cheque a vista'
		when frt.payment_form_id = 3 then 'Cheque Pré'
		when frt.payment_form_id = 4 then 'Cartão Débito'
		when frt.payment_form_id = 5 then 'Cartão Crédito'
		when frt.payment_form_id = 6 then 'Crediário'
		when frt.payment_form_id = 7 then 'Boleto'
		when frt.payment_form_id = 8 then 'Débito'
		when frt.payment_form_id = 9 then 'PIX'
END 'Forma de pagamento'
from financial_receipt_titles frt
INNER JOIN people p ON p.id = frt.client_id
INNER JOIN companies_places cp ON frt.company_place_id = cp.id
INNER JOIN bank_accounts ba ON ba.id = frt.bank_account_id
INNER JOIN financial_receivable_titles frtt ON frtt.id = frt.financial_receivable_title_id
JOIN invoice_notes in2 on frtt.invoice_note_id = in2.id
left join companies_places cpp on cpp.id = in2.company_place_id
left join financial_operations fo on in2.financial_operation_id = fo.id
WHERE frt.receipt_date BETWEEN '2021-10-01' AND '2021-10-31'
-- frt.payment_form_id IS NOT NULL
and frtt.deleted = 0
and fo.id in (61,35,62,32,28,64)
 -- and frtt.title = 'FAT211021180429516'
 -- AND frtt.bill_title_id IS NULL