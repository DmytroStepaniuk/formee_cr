--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.8
-- Dumped by pg_dump version 9.6.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: emails; Type: TABLE; Schema: public; Owner: rogier
--

CREATE TABLE public.emails (
    id bigint NOT NULL,
    from_email character varying(50) NOT NULL,
    from_name character varying(50) NOT NULL,
    sent_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying(50) NOT NULL,
    body text NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    CONSTRAINT body CHECK ((char_length(body) <= 10000)),
    CONSTRAINT from_email_valid CHECK (((from_email)::text ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text)),
    CONSTRAINT from_name CHECK ((char_length((from_name)::text) >= 5)),
    CONSTRAINT title CHECK ((char_length((title)::text) >= 3))
);


ALTER TABLE public.emails OWNER TO rogier;

--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: rogier
--

CREATE SEQUENCE public.emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emails_id_seq OWNER TO rogier;

--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rogier
--

ALTER SEQUENCE public.emails_id_seq OWNED BY public.emails.id;


--
-- Name: employment_conditions; Type: TABLE; Schema: public; Owner: rogier
--

CREATE TABLE public.employment_conditions (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    thirteenth_month boolean DEFAULT false NOT NULL,
    fixed_annual_bonus numeric NOT NULL,
    vacation_days integer NOT NULL,
    variable_annual_bonus numeric(10,2) NOT NULL,
    wage_indexation boolean DEFAULT false NOT NULL,
    monthly_wage_low numeric(10,2) NOT NULL,
    monthly_wage_high numeric(10,2) NOT NULL,
    pension_compensation numeric(10,2) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.employment_conditions OWNER TO rogier;

--
-- Name: employment_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: rogier
--

CREATE SEQUENCE public.employment_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employment_conditions_id_seq OWNER TO rogier;

--
-- Name: employment_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rogier
--

ALTER SEQUENCE public.employment_conditions_id_seq OWNED BY public.employment_conditions.id;


--
-- Name: freelance_conditions; Type: TABLE; Schema: public; Owner: rogier
--

CREATE TABLE public.freelance_conditions (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    hourly_fee_low numeric(10,2) NOT NULL,
    hourly_fee_high numeric(10,2) NOT NULL,
    hours integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.freelance_conditions OWNER TO rogier;

--
-- Name: freelance_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: rogier
--

CREATE SEQUENCE public.freelance_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.freelance_conditions_id_seq OWNER TO rogier;

--
-- Name: freelance_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rogier
--

ALTER SEQUENCE public.freelance_conditions_id_seq OWNED BY public.freelance_conditions.id;


--
-- Name: micrate_db_version; Type: TABLE; Schema: public; Owner: rogier
--

CREATE TABLE public.micrate_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.micrate_db_version OWNER TO rogier;

--
-- Name: micrate_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: rogier
--

CREATE SEQUENCE public.micrate_db_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.micrate_db_version_id_seq OWNER TO rogier;

--
-- Name: micrate_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rogier
--

ALTER SEQUENCE public.micrate_db_version_id_seq OWNED BY public.micrate_db_version.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: rogier
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    encrypted_password character varying(255) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    infix character varying(50),
    admin boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT email_valid CHECK (((email)::text ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text)),
    CONSTRAINT first_name_not_too_short CHECK ((char_length((first_name)::text) >= 2)),
    CONSTRAINT last_name_not_too_short CHECK ((char_length((last_name)::text) >= 2)),
    CONSTRAINT username_not_too_short CHECK ((char_length((username)::text) >= 2))
);


ALTER TABLE public.users OWNER TO rogier;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: rogier
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO rogier;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rogier
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: emails id; Type: DEFAULT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.emails ALTER COLUMN id SET DEFAULT nextval('public.emails_id_seq'::regclass);


--
-- Name: employment_conditions id; Type: DEFAULT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.employment_conditions ALTER COLUMN id SET DEFAULT nextval('public.employment_conditions_id_seq'::regclass);


--
-- Name: freelance_conditions id; Type: DEFAULT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.freelance_conditions ALTER COLUMN id SET DEFAULT nextval('public.freelance_conditions_id_seq'::regclass);


--
-- Name: micrate_db_version id; Type: DEFAULT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.micrate_db_version ALTER COLUMN id SET DEFAULT nextval('public.micrate_db_version_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: emails; Type: TABLE DATA; Schema: public; Owner: rogier
--

COPY public.emails (id, from_email, from_name, sent_at, title, body, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: emails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rogier
--

SELECT pg_catalog.setval('public.emails_id_seq', 1, false);


--
-- Data for Name: employment_conditions; Type: TABLE DATA; Schema: public; Owner: rogier
--

COPY public.employment_conditions (id, email_id, thirteenth_month, fixed_annual_bonus, vacation_days, variable_annual_bonus, wage_indexation, monthly_wage_low, monthly_wage_high, pension_compensation, created_at, updated_at) FROM stdin;
\.


--
-- Name: employment_conditions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rogier
--

SELECT pg_catalog.setval('public.employment_conditions_id_seq', 1, false);


--
-- Data for Name: freelance_conditions; Type: TABLE DATA; Schema: public; Owner: rogier
--

COPY public.freelance_conditions (id, email_id, hourly_fee_low, hourly_fee_high, hours, created_at, updated_at) FROM stdin;
\.


--
-- Name: freelance_conditions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rogier
--

SELECT pg_catalog.setval('public.freelance_conditions_id_seq', 1, false);


--
-- Data for Name: micrate_db_version; Type: TABLE DATA; Schema: public; Owner: rogier
--

COPY public.micrate_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	20180418095748520	t	2018-04-24 20:19:31.290182
2	20180422121744821	t	2018-04-24 20:19:47.817582
3	20180422124340588	t	2018-04-24 20:19:47.823198
4	20180422124352375	t	2018-04-24 20:19:47.829238
\.


--
-- Name: micrate_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rogier
--

SELECT pg_catalog.setval('public.micrate_db_version_id_seq', 4, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: rogier
--

COPY public.users (id, username, email, encrypted_password, first_name, last_name, infix, admin, created_at, updated_at) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rogier
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: employment_conditions employment_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.employment_conditions
    ADD CONSTRAINT employment_conditions_pkey PRIMARY KEY (id);


--
-- Name: freelance_conditions freelance_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.freelance_conditions
    ADD CONSTRAINT freelance_conditions_pkey PRIMARY KEY (id);


--
-- Name: micrate_db_version micrate_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.micrate_db_version
    ADD CONSTRAINT micrate_db_version_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_emails_on_from_email; Type: INDEX; Schema: public; Owner: rogier
--

CREATE INDEX index_emails_on_from_email ON public.emails USING btree (lower((from_email)::text));


--
-- Name: index_emails_on_user_id; Type: INDEX; Schema: public; Owner: rogier
--

CREATE INDEX index_emails_on_user_id ON public.emails USING btree (user_id);


--
-- Name: index_employment_conditions_on_email_id; Type: INDEX; Schema: public; Owner: rogier
--

CREATE INDEX index_employment_conditions_on_email_id ON public.employment_conditions USING btree (email_id);


--
-- Name: index_freelance_conditions_on_email_id; Type: INDEX; Schema: public; Owner: rogier
--

CREATE INDEX index_freelance_conditions_on_email_id ON public.freelance_conditions USING btree (email_id);


--
-- Name: unique_index_users_on_email; Type: INDEX; Schema: public; Owner: rogier
--

CREATE UNIQUE INDEX unique_index_users_on_email ON public.users USING btree (lower((email)::text));


--
-- Name: unique_index_users_on_username; Type: INDEX; Schema: public; Owner: rogier
--

CREATE UNIQUE INDEX unique_index_users_on_username ON public.users USING btree (lower((username)::text));


--
-- Name: freelance_conditions foreign_key_email_id; Type: FK CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.freelance_conditions
    ADD CONSTRAINT foreign_key_email_id FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- Name: employment_conditions foreign_key_email_id; Type: FK CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.employment_conditions
    ADD CONSTRAINT foreign_key_email_id FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- Name: emails foreign_key_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rogier
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT foreign_key_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

