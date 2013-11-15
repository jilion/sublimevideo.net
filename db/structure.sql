--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tailor_made_player_requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tailor_made_player_requests (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    topic character varying(255) NOT NULL,
    job_title character varying(255),
    company character varying(255),
    url character varying(255),
    country character varying(255),
    token character varying(255),
    topic_standalone_detail character varying(255),
    topic_other_detail character varying(255),
    description text NOT NULL,
    document character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    highrise_kase_id integer,
    zendesk_ticket_id integer
);


--
-- Name: tailor_made_player_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tailor_made_player_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tailor_made_player_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tailor_made_player_requests_id_seq OWNED BY tailor_made_player_requests.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tailor_made_player_requests ALTER COLUMN id SET DEFAULT nextval('tailor_made_player_requests_id_seq'::regclass);


--
-- Name: tailor_made_player_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tailor_made_player_requests
    ADD CONSTRAINT tailor_made_player_requests_pkey PRIMARY KEY (id);


--
-- Name: index_tailor_made_player_requests_on_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tailor_made_player_requests_on_created_at ON tailor_made_player_requests USING btree (created_at);


--
-- Name: index_tailor_made_player_requests_on_topic; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tailor_made_player_requests_on_topic ON tailor_made_player_requests USING btree (topic);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20121202170511');

INSERT INTO schema_migrations (version) VALUES ('20121205172815');

INSERT INTO schema_migrations (version) VALUES ('20130117111013');
