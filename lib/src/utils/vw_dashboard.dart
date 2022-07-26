//vw_dashboard
const String vw_dashboard = """ SELECT COALESCE(count(*), 0::bigint) AS ativos,
    COALESCE(sum(c.valor), 0::double precision) AS valortotalcontrato,
    COALESCE(( SELECT count(*) AS inativos
           FROM public.contrato ci
          WHERE ci.status > 1), 0::bigint) AS inativos,
    COALESCE(( SELECT sum(c_1.valor) AS vencidos
           FROM public.contrato c_1
          WHERE c_1.diavencimento::double precision < (( SELECT date_part('Day'::text, CURRENT_DATE) AS date_part)) AND (EXISTS ( SELECT NULL::text AS text
                   FROM public.pagamentos p
                  WHERE (( SELECT date_part('Month'::text, p.datapagamento) AS date_part)) = (( SELECT date_part('Month'::text, CURRENT_DATE) AS date_part))))), 0::double precision) AS vencidos,
    COALESCE(( SELECT sum(p.valorpago - p.desconto) AS pagosematraso
           FROM public.contrato c_1
             JOIN public.pagamentos p ON c_1.idcontrato = p.idcontrato AND (( SELECT date_part('Day'::text, p.datapagamento) AS date_part)) > c_1.diavencimento::double precision AND (( SELECT date_part('Month'::text, p.datapagamento) AS date_part)) = (( SELECT date_part('Month'::text, CURRENT_DATE) AS mesatu))), 0::double precision) AS pagosematraso,
    COALESCE(( SELECT sum(c_1.valor) AS pagosnovencimento
           FROM public.contrato c_1
             JOIN public.pagamentos p ON c_1.idcontrato = p.idcontrato AND (( SELECT date_part('Day'::text, p.datapagamento) AS date_part)) <= c_1.diavencimento::double precision AND (( SELECT date_part('Month'::text, p.datapagamento) AS date_part)) = (( SELECT date_part('Month'::text, CURRENT_DATE) AS date_part))), 0::double precision) AS pagosnovencimento,
    COALESCE(( SELECT sum(p.valorpago) AS sum
           FROM public.pagamentos p
          WHERE COALESCE(( SELECT date_part('Month'::text, p.datapagamento) AS date_part), 0::double precision) = COALESCE(( SELECT date_part('Month'::text, CURRENT_DATE) AS date_part), 0::double precision)), 0::double precision) AS emdia
   FROM public.contrato c
  WHERE c.status = 1;
""";
