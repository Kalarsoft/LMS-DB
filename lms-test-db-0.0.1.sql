--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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

--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


SET default_tablespace = '';

SET default_table_access_method = heap;


--
-- Name: checked_out_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checked_out_item (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    patron_id bigint NOT NULL,
    due_date date NOT NULL
);


ALTER TABLE public.checked_out_item OWNER TO postgres;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(255),
    population integer
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: collection_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collection_item (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    publisher character varying(255) NOT NULL,
    publishing_date character varying(255) NOT NULL,
    loc_number character varying(255),
    dewey_decimal_number character varying(255),
    isbn bigint NOT NULL,
    sort_title character varying(255) NOT NULL,
    format character varying(255) NOT NULL,
    language character varying(255),
    page_count bigint,
    categories character varying(255),
    description character varying(2550),
    price_in_cents bigint,
    cover_image_uri character varying(255),
    is_checked_in boolean NOT NULL,
    is_archived boolean NOT NULL,
    is_lost boolean NOT NULL,
    lost_date date NOT NULL
);


ALTER TABLE public.collection_item OWNER TO postgres;

--
-- Name: collection_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collection_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collection_item_id_seq OWNER TO postgres;

--
-- Name: collection_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collection_item_id_seq OWNED BY public.collection_item.id;


--
-- Name: late_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.late_item (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    patron_id bigint NOT NULL,
    due_date date NOT NULL,
    fees_in_cents integer NOT NULL
);


ALTER TABLE public.late_item OWNER TO postgres;

--
-- Name: late_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.late_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.late_item_id_seq OWNER TO postgres;

--
-- Name: late_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.late_item_id_seq OWNED BY public.late_item.id;


--
-- Name: library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.library (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    is_archived boolean NOT NULL
);


ALTER TABLE public.library OWNER TO postgres;

--
-- Name: library_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.library_collection (
    id bigint NOT NULL,
    library_id bigint NOT NULL,
    item_id bigint NOT NULL
);


ALTER TABLE public.library_collection OWNER TO postgres;

--
-- Name: library_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.library_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.library_collection_id_seq OWNER TO postgres;

--
-- Name: library_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.library_collection_id_seq OWNED BY public.library_collection.id;


--
-- Name: library_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.library_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.library_id_seq OWNER TO postgres;

--
-- Name: library_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.library_id_seq OWNED BY public.library.id;


--
-- Name: lost_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lost_item (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    patron_id bigint NOT NULL,
    due_date date NOT NULL,
    cost_in_cents integer NOT NULL
);


ALTER TABLE public.lost_item OWNER TO postgres;

--
-- Name: lost_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lost_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lost_item_id_seq OWNER TO postgres;

--
-- Name: lost_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lost_item_id_seq OWNED BY public.lost_item.id;


--
-- Name: on_hold_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.on_hold_item (
    id bigint NOT NULL,
    item_id bigint NOT NULL,
    patron_id bigint NOT NULL,
    is_current_hold boolean NOT NULL,
    hold_release_date date NOT NULL
);


ALTER TABLE public.on_hold_item OWNER TO postgres;

--
-- Name: patron; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patron (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    has_good_standing boolean NOT NULL,
    fee_total integer NOT NULL,
    is_archived boolean NOT NULL,
    last_login date NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.patron OWNER TO postgres;

--
-- Name: patron_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patron_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patron_id_seq OWNER TO postgres;

--
-- Name: patron_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patron_id_seq OWNED BY public.patron.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    is_archived boolean NOT NULL
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: collection_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_item ALTER COLUMN id SET DEFAULT nextval('public.collection_item_id_seq'::regclass);


--
-- Name: late_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.late_item ALTER COLUMN id SET DEFAULT nextval('public.late_item_id_seq'::regclass);


--
-- Name: library id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library ALTER COLUMN id SET DEFAULT nextval('public.library_id_seq'::regclass);


--
-- Name: library_collection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_collection ALTER COLUMN id SET DEFAULT nextval('public.library_collection_id_seq'::regclass);


--
-- Name: lost_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lost_item ALTER COLUMN id SET DEFAULT nextval('public.lost_item_id_seq'::regclass);


--
-- Name: patron id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron ALTER COLUMN id SET DEFAULT nextval('public.patron_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: checked_out_item checked_out_item_item_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checked_out_item
    ADD CONSTRAINT checked_out_item_item_id_unique UNIQUE (item_id);


--
-- Name: checked_out_item checked_out_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checked_out_item
    ADD CONSTRAINT checked_out_item_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: collection_item collection_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collection_item
    ADD CONSTRAINT collection_item_pkey PRIMARY KEY (id);


--
-- Name: late_item late_item_item_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.late_item
    ADD CONSTRAINT late_item_item_id_unique UNIQUE (item_id);


--
-- Name: late_item late_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.late_item
    ADD CONSTRAINT late_item_pkey PRIMARY KEY (id);


--
-- Name: library_collection library_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_collection
    ADD CONSTRAINT library_collection_pkey PRIMARY KEY (id);


--
-- Name: library library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library
    ADD CONSTRAINT library_pkey PRIMARY KEY (id);


--
-- Name: lost_item lost_item_item_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lost_item
    ADD CONSTRAINT lost_item_item_id_unique UNIQUE (item_id);


--
-- Name: lost_item lost_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lost_item
    ADD CONSTRAINT lost_item_pkey PRIMARY KEY (id);


--
-- Name: patron patron_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron
    ADD CONSTRAINT patron_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: checked_out_item checked_out_item_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checked_out_item
    ADD CONSTRAINT checked_out_item_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.collection_item(id);


--
-- Name: checked_out_item checked_out_item_patron_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checked_out_item
    ADD CONSTRAINT checked_out_item_patron_id_foreign FOREIGN KEY (patron_id) REFERENCES public.patron(id);


--
-- Name: late_item late_item_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.late_item
    ADD CONSTRAINT late_item_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.collection_item(id);


--
-- Name: late_item late_item_patron_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.late_item
    ADD CONSTRAINT late_item_patron_id_foreign FOREIGN KEY (patron_id) REFERENCES public.patron(id);


--
-- Name: library_collection library_collection_item_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_collection
    ADD CONSTRAINT library_collection_item_foreign FOREIGN KEY (item_id) REFERENCES public.collection_item(id);


--
-- Name: library_collection library_collection_library_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.library_collection
    ADD CONSTRAINT library_collection_library_foreign FOREIGN KEY (library_id) REFERENCES public.library(id);


--
-- Name: lost_item lost_item_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lost_item
    ADD CONSTRAINT lost_item_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.collection_item(id);


--
-- Name: lost_item lost_item_patron_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lost_item
    ADD CONSTRAINT lost_item_patron_id_foreign FOREIGN KEY (patron_id) REFERENCES public.patron(id);


--
-- Name: on_hold_item on_hold_item_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.on_hold_item
    ADD CONSTRAINT on_hold_item_item_id_foreign FOREIGN KEY (item_id) REFERENCES public.collection_item(id);


--
-- Name: on_hold_item on_hold_item_patron_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.on_hold_item
    ADD CONSTRAINT on_hold_item_patron_id_foreign FOREIGN KEY (patron_id) REFERENCES public.patron(id);


--
-- Name: lms_test_pub; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION lms_test_pub WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION lms_test_pub OWNER TO postgres;


--
-- Name: lms_test_pub public; Type: PUBLICATION TABLES IN SCHEMA; Schema: public; Owner: postgres
--

ALTER PUBLICATION lms_test_pub ADD TABLES IN SCHEMA public;


--
-- PostgreSQL database dump complete
--

