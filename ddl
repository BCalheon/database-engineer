CREATE DATABASE performance; 
CREATE TABLE public.dim_pessoas ( 
cpf character varying(11) NOT NULL, 
nome character varying(255), 
sexo character(1) DEFAULT 'M'::bpchar, 
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
INSERT INTO public.dim_pessoas VALUES ('1', 'Vinicius Vale ', 'M', '1985-10-01', false); INSERT INTO public.dim_pessoas VALUES ('2', 'Albertides Valle ', 'M', '1986-10-01', false); 
INSERT INTO public.dim_pessoas VALUES ('4', 'Carlos Rogério ', 'M', '1955-01-11', true); 
INSERT INTO public.dim_pessoas VALUES ('5', 'Almeni Vale ', 'F', '1955-12-23', true); INSERT INTO public.dim_pessoas VALUES ('6', 'Pandora Kan ', 'F', '2000-11-22', true); INSERT INTO public.dim_pessoas VALUES ('3', 'Carla Malu Morais', 'F', '1990-06-23', false); 
INSERT INTO public.dim_status VALUES (1, 'Entregue'); 
INSERT INTO public.dim_status VALUES (0, 'Devolvido'); 
INSERT INTO public.dim_status VALUES (2, 'Processando'); 
INSERT INTO public.dim_status VALUES (3, 'Faturado'); 
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
