SELECT cp.description 'Local',
p.name 'Nome',
frtt.title 'Título',
frtt.competence 'Competencia',
case
		when p.type_tx_id = 2 then 'PF'
		when p.type_tx_id = 1 then 'PJ'
END 'Tipo',
p.city 'Cidade',
ba.description 'Conta',
frt.total_amount 'Valor Total',
frtt.created 'Emissão',
frtt.original_expiration_date ' Data de Vencimento Original',
frtt.expiration_date 'Data de Vencimento',
frt.receipt_date 'Data Recebimento',
fn.title 'Natureza Financeira',
fo.title 'Operação Financeira',
frt.amount 'Valor Recebido',
frt.fine_amount 'Juros',
frt.discount_value 'Desconto',
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
JOIN financers_natures fn on frtt.financer_nature_id = fn.id
join financial_operations fo on frtt.financial_operation_id = fo.id
WHERE frt.receipt_date BETWEEN '2021-09-01' AND '2021-09-30'
AND frt.payment_form_id IS NOT NULL
AND frtt.bill_title_id IS NULL