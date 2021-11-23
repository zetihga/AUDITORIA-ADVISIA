SELECT * /* cp.description 'Local',
p.name 'Nome',
case
		when p.type_tx_id = 2 then 'PF'
		when p.type_tx_id = 1 then 'PJ'
END 'Tipo',
p.city 'Cidade',
ba.description 'Conta',
frt.amount 'Valor Pago',
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
END 'Forma de pagamento' */
from financial_receipt_titles frt
left JOIN people p ON p.id = frt.client_id
left JOIN companies_places cp ON frt.company_place_id = cp.id
left JOIN bank_accounts ba ON ba.id = frt.bank_account_id
left JOIN financial_receivable_titles frtt ON frtt.id = frt.financial_receivable_title_id
left join contracts c on p.id = c.client_id
WHERE frt.receipt_date BETWEEN '2021-06-01' AND '2021-06-30'
AND frt.payment_form_id IS NOT NULL
AND frtt.bill_title_id IS NULL
AND p.name like '%Angelica Albino%'