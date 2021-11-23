select
    count(c.contract_number) quantidade,
    p.name 'Nome',
    c.client_id 'CodCliente',
    c.contract_number 'N° Contrato',
    p.created 'Data cadastro',
    p.phone 'Telefone1',
    p.cell_phone_1 'Telefone2',
    frt.title 'Titulo',
    frt.issue_date 'data emissão',
    frt.expiration_date 'DT de vencimento',
    frt.balance 'Valor'
from financial_receivable_titles frt
join people p on frt.client_id = p.id
left join contracts c ON frt.contract_id = c.id
where frt.balance > 0 and
      frt.renegotiated = 0 and
      frt.bank_title_number is not null
      and p.name like '%Carla Giovanna%'
      and frt.expiration_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 day) AND CURRENT_DATE+1
      and frt.deleted = 0
      GROUP BY c.contract_number
      having quantidade = 1
