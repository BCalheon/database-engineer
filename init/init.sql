-- Criação das tabelas
CREATE TABLE public.dim_pessoas (
  cpf character varying(11) NOT NULL,
  nome character varying(255),
  sexo character(1) DEFAULT 'M',
  dt_nasc date,
  is_vendedor boolean DEFAULT false
);

CREATE TABLE public.dim_status (
  cod_status integer NOT NULL,
  status character varying(20)
);

CREATE TABLE public.fact_venda (
  cod_venda bigserial NOT NULL,
  cod_cli character varying(11) NOT NULL,
  cod_vend character varying(11) NOT NULL,
  qtde_venda integer DEFAULT 0,
  vl_total numeric(10,2) DEFAULT 0,
  dt_venda date
);

-- Inserção dos dados base
INSERT INTO public.dim_pessoas VALUES 
  ('1', 'Vinicius Vale', 'M', '1985-10-01', false),
  ('2', 'Albertides Valle', 'M', '1986-10-01', false),
  ('4', 'Carlos Rogério', 'M', '1955-01-11', true),
  ('5', 'Almeni Vale', 'F', '1955-12-23', true),
  ('6', 'Pandora Kan', 'F', '2000-11-22', true),
  ('3', 'Carla Malu Morais', 'F', '1990-06-23', false);

INSERT INTO public.dim_status VALUES
  (1, 'Entregue'),
  (0, 'Devolvido'),
  (2, 'Processando'),
  (3, 'Faturado');

-- Definição de PKs e FKs
ALTER TABLE ONLY public.dim_pessoas
  ADD CONSTRAINT pk_pessoas PRIMARY KEY (cpf);

ALTER TABLE ONLY public.dim_status
  ADD CONSTRAINT pk_status PRIMARY KEY (cod_status);

ALTER TABLE ONLY public.fact_venda
  ADD CONSTRAINT pk_vendas PRIMARY KEY (cod_venda);

ALTER TABLE ONLY public.fact_venda
  ADD CONSTRAINT fk_pessoas FOREIGN KEY (cod_cli) REFERENCES public.dim_pessoas(cpf);

ALTER TABLE ONLY public.fact_venda
  ADD CONSTRAINT fk_pessoas_vendedor FOREIGN KEY (cod_vend) REFERENCES public.dim_pessoas(cpf);

-- Geração de 1 milhão de registros aleatórios
INSERT INTO fact_venda(cod_cli, cod_vend, qtde_venda, vl_total, dt_venda)
SELECT
  floor(random() * (7 - 4) + 4)::int::text,
  floor(random() * (4 - 1) + 1)::int::text,
  floor(random() * (21 - 1) + 1),
  floor(random() * (10000 - 100) + 100),
  CAST(
    CASE floor(random() * (6 - 1) + 1)
      WHEN 1 THEN '2022-01-01'
      WHEN 2 THEN '2022-02-01'
      WHEN 3 THEN '2022-03-01'
      WHEN 4 THEN '2022-04-01'
      WHEN 5 THEN '2022-05-01'
      ELSE '2022-12-31'
    END AS DATE
  )
FROM generate_series(1, 1000000);
