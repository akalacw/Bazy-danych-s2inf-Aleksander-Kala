--
-- PostgreSQL database dump
--

\restrict qAEe4wowT8BQcZ7XaKpXU40gRANWYEe5cY0MUKY5XOgrap9Rq1EoLKPUhO9eBHn

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-07 15:46:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16492)
-- Name: kategorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategorie (
    id integer NOT NULL,
    nazwa character varying(100),
    opis text
);


ALTER TABLE public.kategorie OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16491)
-- Name: kategorie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategorie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kategorie_id_seq OWNER TO postgres;

--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 219
-- Name: kategorie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategorie_id_seq OWNED BY public.kategorie.id;


--
-- TOC entry 224 (class 1259 OID 16515)
-- Name: klienci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.klienci (
    id integer NOT NULL,
    imie character varying(50),
    nazwisko character varying(50),
    email character varying(100),
    data_rejestracji date,
    miasto character varying(50)
);


ALTER TABLE public.klienci OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16514)
-- Name: klienci_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.klienci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.klienci_id_seq OWNER TO postgres;

--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 223
-- Name: klienci_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.klienci_id_seq OWNED BY public.klienci.id;


--
-- TOC entry 226 (class 1259 OID 16523)
-- Name: pracownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pracownicy (
    id integer NOT NULL,
    imie character varying(50),
    nazwisko character varying(50),
    stanowisko character varying(50),
    data_zatrudnienia date
);


ALTER TABLE public.pracownicy OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16522)
-- Name: pracownicy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pracownicy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pracownicy_id_seq OWNER TO postgres;

--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 225
-- Name: pracownicy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pracownicy_id_seq OWNED BY public.pracownicy.id;


--
-- TOC entry 222 (class 1259 OID 16502)
-- Name: produkty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produkty (
    id integer NOT NULL,
    nazwa character varying(150),
    kategoria_id integer,
    cena numeric(10,2),
    ilosc_magazyn integer,
    data_dodania date
);


ALTER TABLE public.produkty OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16501)
-- Name: produkty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produkty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produkty_id_seq OWNER TO postgres;

--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 221
-- Name: produkty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produkty_id_seq OWNED BY public.produkty.id;


--
-- TOC entry 228 (class 1259 OID 16531)
-- Name: zamowienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zamowienia (
    id integer NOT NULL,
    klient_id integer,
    pracownik_id integer,
    data_zamowienia date,
    status character varying(30)
);


ALTER TABLE public.zamowienia OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16530)
-- Name: zamowienia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zamowienia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zamowienia_id_seq OWNER TO postgres;

--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 227
-- Name: zamowienia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zamowienia_id_seq OWNED BY public.zamowienia.id;


--
-- TOC entry 4876 (class 2604 OID 16495)
-- Name: kategorie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategorie ALTER COLUMN id SET DEFAULT nextval('public.kategorie_id_seq'::regclass);


--
-- TOC entry 4878 (class 2604 OID 16518)
-- Name: klienci id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci ALTER COLUMN id SET DEFAULT nextval('public.klienci_id_seq'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16526)
-- Name: pracownicy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy ALTER COLUMN id SET DEFAULT nextval('public.pracownicy_id_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 16505)
-- Name: produkty id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produkty ALTER COLUMN id SET DEFAULT nextval('public.produkty_id_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 16534)
-- Name: zamowienia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia ALTER COLUMN id SET DEFAULT nextval('public.zamowienia_id_seq'::regclass);


--
-- TOC entry 5042 (class 0 OID 16492)
-- Dependencies: 220
-- Data for Name: kategorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategorie (id, nazwa, opis) FROM stdin;
1	Elektronika	Sprzęt elektroniczny
2	Ksiazki	Literatura piękna i naukowa
\.


--
-- TOC entry 5046 (class 0 OID 16515)
-- Dependencies: 224
-- Data for Name: klienci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.klienci (id, imie, nazwisko, email, data_rejestracji, miasto) FROM stdin;
1	Jan	Kowalski	jan.kowalski@example.com	2026-04-21	Wroclaw
2	Anna	Nowak	anna.nowak@example.com	2025-03-17	Poznan
3	Piotr	Wisniewski	piotr.w@example.com	2026-07-30	Warszawa
4	Katarzyna	Adamska	k.adamska@example.com	2026-09-18	Wroclaw
\.


--
-- TOC entry 5048 (class 0 OID 16523)
-- Dependencies: 226
-- Data for Name: pracownicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pracownicy (id, imie, nazwisko, stanowisko, data_zatrudnienia) FROM stdin;
1	Tomasz	Maj	Sprzedawca	2023-01-15
2	Magdalena	Kaczmarek	Kierownik	2021-05-10
\.


--
-- TOC entry 5044 (class 0 OID 16502)
-- Dependencies: 222
-- Data for Name: produkty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produkty (id, nazwa, kategoria_id, cena, ilosc_magazyn, data_dodania) FROM stdin;
1	Laptop Pro 15	1	3500.00	4	2026-10-28
2	Mysz bezprzewodowa	1	95.50	25	2026-11-02
3	Klawiatura mechaniczna	1	220.00	3	2026-09-08
4	Monitor 27 cali	1	1100.00	2	2026-07-10
5	Pendrive 64GB	1	45.00	150	2026-11-05
6	Pioro wieczne	2	105.00	12	2026-10-23
7	Zestaw pisakow	2	25.00	8	2025-10-03
\.


--
-- TOC entry 5050 (class 0 OID 16531)
-- Dependencies: 228
-- Data for Name: zamowienia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zamowienia (id, klient_id, pracownik_id, data_zamowienia, status) FROM stdin;
1	1	1	2026-11-05	zrealizowane
2	2	1	2026-11-02	anulowane
3	3	2	2026-11-06	nowe
4	4	2	2026-10-28	anulowane
\.


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 219
-- Name: kategorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategorie_id_seq', 2, true);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 223
-- Name: klienci_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.klienci_id_seq', 4, true);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 225
-- Name: pracownicy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pracownicy_id_seq', 2, true);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 221
-- Name: produkty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produkty_id_seq', 7, true);


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 227
-- Name: zamowienia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zamowienia_id_seq', 4, true);


--
-- TOC entry 4882 (class 2606 OID 16500)
-- Name: kategorie kategorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategorie
    ADD CONSTRAINT kategorie_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 16521)
-- Name: klienci klienci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (id);


--
-- TOC entry 4888 (class 2606 OID 16529)
-- Name: pracownicy pracownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (id);


--
-- TOC entry 4884 (class 2606 OID 16508)
-- Name: produkty produkty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produkty
    ADD CONSTRAINT produkty_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 16537)
-- Name: zamowienia zamowienia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (id);


--
-- TOC entry 4891 (class 2606 OID 16509)
-- Name: produkty produkty_kategoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produkty
    ADD CONSTRAINT produkty_kategoria_id_fkey FOREIGN KEY (kategoria_id) REFERENCES public.kategorie(id);


--
-- TOC entry 4892 (class 2606 OID 16538)
-- Name: zamowienia zamowienia_klient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_klient_id_fkey FOREIGN KEY (klient_id) REFERENCES public.klienci(id);


--
-- TOC entry 4893 (class 2606 OID 16543)
-- Name: zamowienia zamowienia_pracownik_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pracownik_id_fkey FOREIGN KEY (pracownik_id) REFERENCES public.pracownicy(id);


-- Completed on 2026-11-07 15:46:24

--
-- PostgreSQL database dump complete
--

\unrestrict qAEe4wowT8BQcZ7XaKpXU40gRANWYEe5cY0MUKY5XOgrap9Rq1EoLKPUhO9eBHn

