--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: siasisten; Type: SCHEMA; Schema: -; Owner: asa.fairuz
--

CREATE SCHEMA siasisten;


ALTER SCHEMA siasisten OWNER TO "asa.fairuz";

SET search_path = siasisten, pg_catalog;

--
-- Name: hitung_jlh_pelamar_diterima(); Type: FUNCTION; Schema: siasisten; Owner: asa.fairuz
--

CREATE FUNCTION hitung_jlh_pelamar_diterima() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF(NEW.id_st_lamaran=3) THEN
UPDATE lowongan set jumlah_pelamar_diterima=jumlah_pelamar_diterima+1
WHERE lowongan.idLowongan=new.idLowongan;
END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION siasisten.hitung_jlh_pelamar_diterima() OWNER TO "asa.fairuz";

--
-- Name: tambah_jumlah_pelamar(); Type: FUNCTION; Schema: siasisten; Owner: asa.fairuz
--

CREATE FUNCTION tambah_jumlah_pelamar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE lowongan set jumlah_pelamar= jumlah_pelamar+1
WHERE lowongan.idLowongan=new.idLowongan;
RETURN NEW;
END;
$$;


ALTER FUNCTION siasisten.tambah_jumlah_pelamar() OWNER TO "asa.fairuz";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dosen; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE dosen (
    nip character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    universitas character varying(100) NOT NULL,
    fakultas character varying(100) NOT NULL
);


ALTER TABLE dosen OWNER TO "asa.fairuz";

--
-- Name: dosen_kelas_mk; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE dosen_kelas_mk (
    nip character varying(20) NOT NULL,
    idkelasmk integer NOT NULL
);


ALTER TABLE dosen_kelas_mk OWNER TO "asa.fairuz";

--
-- Name: kategori_log; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE kategori_log (
    id integer NOT NULL,
    kategori character varying(50) NOT NULL
);


ALTER TABLE kategori_log OWNER TO "asa.fairuz";

--
-- Name: kelas_mk; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE kelas_mk (
    idkelasmk integer NOT NULL,
    tahun integer NOT NULL,
    semester integer NOT NULL,
    kode_mk character(10) NOT NULL
);


ALTER TABLE kelas_mk OWNER TO "asa.fairuz";

--
-- Name: lamaran; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE lamaran (
    idlamaran integer NOT NULL,
    npm character(10) NOT NULL,
    idlowongan integer NOT NULL,
    id_st_lamaran integer NOT NULL,
    ipk numeric(5,2) NOT NULL,
    jumlahsks integer NOT NULL,
    nip character varying(20)
);


ALTER TABLE lamaran OWNER TO "asa.fairuz";

--
-- Name: log; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE log (
    idlog integer NOT NULL,
    idlamaran integer NOT NULL,
    npm character(10) NOT NULL,
    id_kat_log integer NOT NULL,
    id_st_log integer NOT NULL,
    tanggal date NOT NULL,
    jam_mulai time without time zone NOT NULL,
    jam_selesai time without time zone NOT NULL,
    deskripsi_kerja character varying(100) NOT NULL
);


ALTER TABLE log OWNER TO "asa.fairuz";

--
-- Name: lowongan; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE lowongan (
    idlowongan integer NOT NULL,
    idkelasmk integer NOT NULL,
    status boolean DEFAULT false NOT NULL,
    jumlah_asisten character varying(100) DEFAULT 0 NOT NULL,
    syarat_tambahan character varying(20),
    nipdosenpembuka character varying(20) NOT NULL,
    jumlah_pelamar integer DEFAULT 0,
    jlh_pelamar_diterima integer DEFAULT 0
);


ALTER TABLE lowongan OWNER TO "asa.fairuz";

--
-- Name: mahasiswa; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE mahasiswa (
    npm character(10) NOT NULL,
    nama character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    email_aktif character varying(100),
    waktu_kosong character varying(100),
    bank character varying(100),
    norekening character varying(100),
    url_mukatab character varying(100),
    url_foto character varying(100)
);


ALTER TABLE mahasiswa OWNER TO "asa.fairuz";

--
-- Name: mata_kuliah; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE mata_kuliah (
    kode character(10) NOT NULL,
    nama character varying(100) NOT NULL,
    prasyarat_dari character(10)
);


ALTER TABLE mata_kuliah OWNER TO "asa.fairuz";

--
-- Name: mhs_mengambil_kelas_mk; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE mhs_mengambil_kelas_mk (
    npm character(10) NOT NULL,
    idkelasmk integer NOT NULL,
    nilai numeric(5,2) NOT NULL
);


ALTER TABLE mhs_mengambil_kelas_mk OWNER TO "asa.fairuz";

--
-- Name: status_lamaran; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE status_lamaran (
    id integer NOT NULL,
    status character varying(20) NOT NULL
);


ALTER TABLE status_lamaran OWNER TO "asa.fairuz";

--
-- Name: status_log; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE status_log (
    id integer NOT NULL,
    status character varying(10) NOT NULL
);


ALTER TABLE status_log OWNER TO "asa.fairuz";

--
-- Name: telepon_mahasiswa; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE telepon_mahasiswa (
    npm character(10) NOT NULL,
    nomortelepon character varying(20) NOT NULL
);


ALTER TABLE telepon_mahasiswa OWNER TO "asa.fairuz";

--
-- Name: term; Type: TABLE; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

CREATE TABLE term (
    tahun integer NOT NULL,
    semester integer NOT NULL
);


ALTER TABLE term OWNER TO "asa.fairuz";

--
-- Data for Name: dosen; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY dosen (nip, nama, username, password, email, universitas, fakultas) FROM stdin;
121303010	Arlisa Yuliawati	arlisa	arlisa123	arlisa@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
121303009	Alfan Farizki Wicaksono	alfan	alfan123	alfan@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
121203009	Hanif Rasyidi	hanifr	hanifr123	hanifr@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
197704182012121003	Denny	denny	denny123	denny@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
198704262012121002	Bayu Distiawan	bayu	bayu123	bayu@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
196201021992031003	Yugo Kartono Isal	yugo	yugo123	yugo@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
120903014	Rahmat Budiarto	rahmatb	rahmatb123	rahmatb@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
121113004	Lelya Rimadhiana	lelya	lelya123	lelya@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
121403002	Maya Retno	maya	maya123	maya@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
195906171985032002	Erdefi Rakun	erdefi	erdefi123	erdefi@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
195304201989031002	Iik Wilarso	iik	iik123	iik@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
121103004	Puspa Indahati	puspa	puspa123	puspa@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
30603001	Belawati	bela	bela123	bela@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
195903251993111001	Lim Yohanes	lim	lim123	lim@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
121203004	Hadaiq Rolis	hadaiqr	hadaiqr123	hadaiqr@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
120803003	Harry Budi Santoso	harrybs	harrybs123	harrybs@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
194901071976031001	Toemin	toemin	toemin123	toemin@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
1208050380	Ruli Manurung	rulim	rulim123	rulim@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
197603012008121001	Indra Budi	indra	indra123	indra@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
1208050382	Wisnu Jatmiko	wisnuj	wisnuj123	wisnuj@cs.ui.ac.id	universitas indonesia	fakultas ilmu komputer
51-440-8220	Juan Owens	nmason0	QdhiACUGTwl	lhenderson0@bloomberg.com	New Economic School	computer science
61-099-7306	Patrick Morgan	rortiz1	tuxAACy8S	ahowell1@army.mil	Lappeenranta University of Technology	computer science
58-361-8873	Michelle Lawrence	afowler2	qt5Eg8gDeh	hwilson2@wsj.com	Chongju National University of Education	computer science
99-362-9320	Juan Burton	gnichols3	TNJXON	tferguson3@odnoklassniki.ru	Senzoku Gakuen College	computer science
80-025-8973	Martha Gonzalez	pcunningham4	PkC8m8xpXg	vgrant4@unc.edu	Wonkwang University	computer science
74-969-0531	Nancy Mills	raustin5	pK1kk4LY6	jbailey5@naver.com	Darul Quran Islamic College University	computer science
73-269-0824	Gloria Armstrong	jwilliams6	aHelZdhOl7N	jstephens6@wunderground.com	Universidad de Atacama	computer science
42-033-8510	Linda Castillo	klane7	c1hJl2rQV3	pday7@sciencedaily.com	Nanyang Technological University	computer science
51-914-9425	Marilyn Taylor	amorgan8	rvekDp	rmorris8@washington.edu	Sanaag University of Science and Technology	computer science
54-782-1775	Anthony Alvarez	jross9	1WYFtC	jgeorge9@studiopress.com	Free University Amsterdam	computer science
28-901-9912	Anne Rice	whawkinsa	V4b8zNy	scoxa@ehow.com	Dokuz Eylül University	computer science
64-855-4980	Sandra Reed	jsullivanb	RXgLeHZ	lrileyb@pinterest.com	University of Groningen	computer science
82-081-9325	Joshua Howell	egeorgec	2RmVo6hcvT6C	kwoodsc@so-net.ne.jp	Philosophisch-Theologische Hochschule der Salesianer Don Boscos	computer science
15-243-9029	Jessica Coleman	mlittled	VqVqIgtD8N	ttorresd@mtv.com	Tsuda College	computer science
80-350-7337	Daniel Kennedy	bwoode	cJNJNGD	lmorrisone@pagesperso-orange.fr	West Minster International College	computer science
62-903-9894	Beverly Coleman	nwardf	GUoTFf	tharperf@amazon.com	Kashan University	computer science
69-110-3111	Phyllis Crawford	wgarciag	8ZU61r2sC	shudsong@wisc.edu	Institut Catholique de Paris	computer science
65-342-9583	Eric Gonzales	rhenryh	oywbAkgoW	bhowardh@shutterfly.com	Upper Nile University	computer science
35-088-0866	Kelly Phillips	jnelsoni	HVPrxLF	hfulleri@oracle.com	Jönköping University College	computer science
08-195-9692	Pamela Stewart	ldunnj	AGRN9gK	mmartinj@wordpress.org	Research College of Nursing - Rockhurst University	computer science
14-849-6944	Kathy Crawford	dhowardk	WxNlDHq1l0I	randrewsk@example.com	University of Maine, Presque Isle	computer science
81-489-6883	Louise Ross	gblackl	1aq9CQZue6f	rlawrencel@google.ru	Musashino Womens University	computer science
86-784-2913	Cynthia Little	jgeorgem	cEWpyS	hfullerm@apache.org	Universidad de Atacama	computer science
95-635-5009	Ashley Rodriguez	jgeorgen	5jhjuA	wcarrn@usatoday.com	Al Rafidain University College	computer science
49-257-9346	Melissa Owens	ptorreso	rsJU9zGrD	dshawo@google.pl	Shanghai Customs College	computer science
26-151-7377	Chris Roberts	jcollinsp	OJZkql3	kleep@businessinsider.com	St. Francis Medical Center College of Nursing	computer science
92-437-7261	Sean Carter	snguyenq	qrzt2ZYuQ	mboydq@psu.edu	Universidad Santo Tomás	computer science
06-628-5019	Lawrence Fisher	mfosterr	qfHo8F0Gz	rstephensr@indiatimes.com	Universidad Señor de Sipán	computer science
96-192-0479	Betty Baker	awatkinss	13iXqL	rstevenss@house.gov	Universidad de Oriente	computer science
29-569-6922	Frank Hart	lbradleyt	Cvc97Ch	rmyerst@upenn.edu	Widener University	computer science
\.


--
-- Data for Name: dosen_kelas_mk; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY dosen_kelas_mk (nip, idkelasmk) FROM stdin;
30603001	1
121303010	1
120803003	2
121303009	2
195903251993111001	2
120903014	3
121203009	3
121103004	4
121303009	4
197704182012121003	4
121113004	5
198704262012121002	5
121203004	6
196201021992031003	6
120903014	7
121203009	7
121113004	8
121303009	8
121403002	9
80-025-8973	9
194901071976031001	10
195906171985032002	10
195304201989031002	11
196201021992031003	11
74-969-0531	11
121103004	12
30603001	13
195903251993111001	14
121203004	15
120803003	16
194901071976031001	17
121203009	18
1208050380	18
197603012008121001	19
1208050382	20
121403002	21
197603012008121001	21
198704262012121002	21
51-440-8220	21
1208050380	22
42-033-8510	22
51-440-8220	22
61-099-7306	22
58-361-8873	23
99-362-9320	24
80-025-8973	25
74-969-0531	26
73-269-0824	27
42-033-8510	28
121303010	29
51-914-9425	29
194901071976031001	30
195304201989031002	31
99-362-9320	31
195903251993111001	32
195906171985032002	33
195906171985032002	34
196201021992031003	34
197603012008121001	35
197704182012121003	36
198704262012121002	37
121103004	38
121303010	38
197704182012121003	38
121113004	39
121203004	40
121203009	41
195304201989031002	41
121303009	42
121303010	43
121403002	43
121403002	44
42-033-8510	45
51-440-8220	46
51-914-9425	47
58-361-8873	48
61-099-7306	49
51-914-9425	50
73-269-0824	50
195304201989031002	45
\.


--
-- Data for Name: kategori_log; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY kategori_log (id, kategori) FROM stdin;
1	asistensi/tutorial
2	persiapan asistensi
3	membuat soal/tugas
4	rapat
5	sit in kelas
6	mengoreksi
7	mengawas
\.


--
-- Data for Name: kelas_mk; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY kelas_mk (idkelasmk, tahun, semester, kode_mk) FROM stdin;
1	2014	1	CSGE602040
2	2015	2	CSIM603026
3	2016	3	CSIM603229
4	2014	1	CSIM601251
5	2015	2	CSGE602055
6	2016	3	CSIM603154
7	2014	1	CSIM602160
8	2015	2	CSIM602266
9	2016	3	CSGE603291
10	2014	1	CSGE604099
11	2015	2	CSGE602040
12	2016	3	CSIM603026
13	2014	1	CSIM603229
14	2015	2	CSIM601251
15	2016	3	CSGE602055
16	2014	1	CSIM603154
17	2015	2	CSIM602160
18	2016	3	CSIM602266
19	2014	1	CSGE603291
20	2015	2	CSGE604099
21	2016	3	RANDOM0003
22	2014	1	RANDOM0004
23	2015	2	RANDOM0005
24	2016	3	RANDOM0006
25	2016	3	RANDOM0007
26	2015	2	RANDOM0008
27	2014	1	RANDOM0009
28	2016	3	RANDOM0010
29	2015	2	RANDOM0008
30	2014	1	RANDOM0009
31	2016	3	RANDOM0010
32	2015	2	RANDOM0011
33	2014	1	RANDOM0012
34	2016	3	RANDOM0013
35	2015	2	RANDOM0014
36	2014	1	RANDOM0015
37	2016	3	RANDOM0016
38	2015	2	RANDOM0017
39	2014	1	RANDOM0018
40	2015	2	RANDOM0019
41	2014	1	RANDOM0020
42	2016	3	RANDOM0021
43	2015	2	RANDOM0022
44	2014	1	RANDOM0023
45	2016	3	RANDOM0024
46	2015	2	RANDOM0025
47	2014	1	RANDOM0026
48	2016	3	RANDOM0027
49	2015	2	RANDOM0028
50	2014	1	RANDOM0029
\.


--
-- Data for Name: lamaran; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY lamaran (idlamaran, npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) FROM stdin;
1	1406543864	32	2	3.93	127	121303010
2	1406568753	6	4	2.90	65	121303009
3	1506797564	3	3	3.33	27	121203009
4	1521338802	11	2	2.61	55	197704182012121003
5	1306381982	15	2	3.32	98	198704262012121002
6	1306413252	28	2	3.65	120	196201021992031003
7	1406572025	13	3	3.68	92	120903014
8	1306409500	6	1	3.01	95	121113004
9	1406543851	13	2	3.85	114	121403002
10	1406559963	24	1	3.22	104	195906171985032002
11	1406567536	18	3	3.55	92	195304201989031002
12	1358344759	24	3	3.33	122	121103004
13	1306381982	32	3	3.32	98	30603001
14	1306381931	1	2	3.21	115	195903251993111001
15	1306381686	22	2	3.87	122	121203004
16	1406543864	7	2	3.93	127	120803003
17	1406568753	31	1	2.90	65	194901071976031001
18	1406572025	12	3	3.93	100	1208050380
19	1437485954	48	4	3.87	105	197603012008121001
20	1406543864	39	1	3.93	127	1208050382
21	1345675618	20	2	3.00	128	51-440-8220
22	1322230380	21	2	3.80	142	61-099-7306
23	1495635098	29	2	3.67	77	58-361-8873
24	1547724531	11	3	3.67	70	99-362-9320
25	1365223948	3	2	3.45	135	80-025-8973
26	1388445371	29	2	3.90	131	74-969-0531
27	1310788111	50	1	3.29	110	73-269-0824
28	1428766349	11	2	3.48	129	42-033-8510
29	1428658967	5	4	3.32	100	51-914-9425
30	1495635098	41	3	3.23	94	54-782-1775
31	1331286498	20	3	3.06	135	28-901-9912
32	1480616954	10	2	3.67	70	64-855-4980
33	1306381982	14	4	3.32	98	82-081-9325
34	1358344759	27	3	3.33	122	15-243-9029
35	1359126319	12	2	3.05	127	80-350-7337
36	1386263953	12	3	3.45	134	62-903-9894
37	1352861996	20	2	3.55	115	69-110-3111
38	1364465102	31	2	3.30	119	65-342-9583
39	1504843053	42	4	3.85	47	35-088-0866
40	1437485954	34	4	2.77	78	08-195-9692
41	1483310896	7	1	3.13	91	14-849-6944
42	1582194861	20	4	3.87	65	81-489-6883
43	1357615465	3	1	2.42	39	86-784-2913
44	1406568753	2	2	2.90	65	95-635-5009
45	1306381982	16	1	3.32	98	49-257-9346
46	1504843053	29	1	3.85	47	26-151-7377
47	1406559963	2	3	3.05	105	92-437-7261
48	1306381881	50	2	3.03	116	06-628-5019
49	1306381931	35	4	3.67	134	96-192-0479
50	1306381686	38	4	3.96	132	29-569-6922
51	1504843053	29	1	3.85	47	121303010
52	1426858859	13	1	3.10	95	121303009
53	1306381931	4	1	3.21	115	121203009
54	1306381686	44	3	3.87	122	1208050380
55	1453920347	48	4	3.72	105	81-489-6883
56	1453689544	7	3	3.35	106	1208050382
57	1372154114	41	4	2.99	115	120903014
58	1372154114	20	3	3.69	81	121113004
59	1315099171	37	2	2.98	39	121403002
60	1453920347	8	4	3.72	105	120903014
61	1483717072	45	3	3.11	121	121113004
62	1493494807	38	4	3.72	105	121103004
63	1480976061	15	4	3.16	83	30603001
64	1428658967	39	2	3.31	35	121203004
65	1306413252	26	2	3.45	109	121203004
66	1453689544	7	3	3.35	106	120803003
67	1327230946	37	1	3.29	113	194901071976031001
68	1547724531	19	1	2.78	56	195906171985032002
69	1372154114	24	4	2.99	115	195304201989031002
70	1417684658	10	2	2.13	24	195903251993111001
71	1408858242	4	2	2.45	81	51-440-8220
72	1504843053	28	1	3.85	47	61-099-7306
73	1426858859	8	4	3.10	95	58-361-8873
74	1506959924	42	1	3.94	50	99-362-9320
75	1309554205	48	4	3.59	74	80-025-8973
76	1306413252	3	4	3.45	109	74-969-0531
77	1504843053	24	3	3.85	47	73-269-0824
78	1567289372	25	1	3.29	43	42-033-8510
79	1602334345	39	1	3.29	126	51-914-9425
80	1545529945	29	1	3.64	88	54-782-1775
81	1306381881	37	4	3.03	116	28-901-9912
82	1306381931	18	4	3.67	134	64-855-4980
83	1306381686	42	4	3.96	132	82-081-9325
84	1306381881	26	1	3.03	116	15-243-9029
85	1306381931	21	2	3.67	134	80-350-7337
86	1306381686	45	4	3.96	132	62-903-9894
87	1597284299	50	1	3.95	70	69-110-3111
88	1307826688	47	4	3.38	124	65-342-9583
89	1328358017	22	2	3.90	130	35-088-0866
90	1561473091	43	4	3.63	43	08-195-9692
91	1406559963	25	2	3.05	105	14-849-6944
92	1406559963	23	3	3.47	85	81-489-6883
93	1426858859	3	3	3.58	103	86-784-2913
94	1406559963	25	4	3.05	105	95-635-5009
95	1306381881	41	1	3.03	116	49-257-9346
96	1306381931	17	1	3.67	134	26-151-7377
97	1306381686	25	4	3.96	132	92-437-7261
98	1426858859	39	4	3.58	103	06-628-5019
99	1306381931	17	2	3.67	134	120903014
100	1328358017	45	3	3.27	131	121113004
101	1561473091	40	4	3.63	43	121403002
102	1483310896	33	4	3.12	81	121103004
103	1306381881	12	2	3.03	116	30603001
104	1562679184	20	2	3.23	86	96-192-0479
105	1406543946	22	2	3.72	129	29-569-6922
106	1406543933	48	4	3.59	115	196201021992031003
107	1406559963	44	2	3.47	85	195906171985032002
108	1306381881	38	3	3.03	116	195304201989031002
109	1406568015	50	4	3.64	107	08-195-9692
110	1406566054	14	1	3.86	121	14-849-6944
111	1307826688	10	1	3.38	124	81-489-6883
112	1328358017	44	2	3.90	130	86-784-2913
113	1310159588	22	2	3.29	135	95-635-5009
114	1427360641	24	2	3.59	90	49-257-9346
115	1447036114	18	2	3.50	82	121303010
116	1406543851	50	2	3.85	114	121303009
117	1406559963	49	1	3.22	104	121203009
118	1406567536	24	4	3.55	92	1208050380
119	1406623165	22	3	3.34	92	1208050382
120	1406574623	31	2	3.46	98	1208050382
121	1406544116	29	3	2.56	111	51-440-8220
122	1406623146	24	2	3.43	24	61-099-7306
123	1506797545	13	3	3.78	86	58-361-8873
124	1406574516	25	4	3.40	80	99-362-9320
125	1406623240	49	3	3.19	64	80-025-8973
126	1406623442	22	4	3.71	112	74-969-0531
127	1459300527	23	4	2.83	121	73-269-0824
128	1506797545	19	4	3.78	86	42-033-8510
129	1506797596	45	4	2.67	136	51-914-9425
130	1562679184	31	4	3.23	86	54-782-1775
131	1406543946	31	4	3.72	129	28-901-9912
132	1406543933	16	3	3.59	115	64-855-4980
133	1406577064	11	3	3.23	84	82-081-9325
134	1406559963	47	4	3.05	105	15-243-9029
135	1310788111	39	1	3.34	122	80-350-7337
136	1426858859	36	2	3.58	103	62-903-9894
137	1310788111	20	3	3.34	122	69-110-3111
138	1306381881	41	1	3.03	116	65-342-9583
139	1433980142	1	3	2.89	81	35-088-0866
140	1406543933	13	1	3.59	115	121303010
141	1406543946	12	3	3.72	129	121303009
142	1406559963	16	4	3.05	105	121203009
143	1506797545	19	4	3.78	86	1208050380
144	1406623442	17	2	3.71	112	1208050382
145	1428766349	34	2	3.53	108	1208050382
146	1306381931	37	3	3.67	134	26-151-7377
147	1406559963	27	3	3.05	105	92-437-7261
148	1406559963	44	4	3.47	85	06-628-5019
149	1426858859	47	1	3.58	103	96-192-0479
150	1406559963	30	4	3.05	105	29-569-6922
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY log (idlog, idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) FROM stdin;
1	1	1406543864	4	4	2016-01-19	17:09:00	21:58:00	rapat membahas tugas
2	2	1406568753	7	1	2016-09-08	08:21:00	18:12:00	mengawas ujian
3	3	1506797564	2	3	2016-04-19	11:09:00	12:23:00	persiapan asistensi sebelum UTS
4	4	1521338802	3	3	2016-07-07	12:22:00	12:24:00	membuat soal/tugas latihan 1
5	5	1306381982	2	2	2016-03-08	09:23:00	18:12:00	persiapan asistensi sebelum UTS
6	6	1306413252	5	4	2016-07-07	16:31:00	22:32:00	sit in kelas
7	7	1406572025	3	3	2016-07-21	21:10:00	22:20:00	membuat soal/tugas latihan 1
8	8	1306409500	4	4	2015-07-12	19:12:00	21:37:00	rapat membahas tugas
9	9	1406543851	6	4	2016-04-20	18:34:00	22:20:00	mengoreksi
10	10	1406559963	5	1	2016-06-18	21:48:00	22:49:00	sit in kelas
11	11	1406567536	6	1	2016-07-26	20:17:00	21:37:00	mengoreksi
12	12	1358344759	6	1	2016-07-16	20:30:00	22:06:00	mengoreksi
13	13	1306381982	3	3	2016-07-01	22:27:00	23:02:00	membuat soal/tugas latihan 1
14	14	1306381931	2	3	2016-06-22	15:19:00	21:00:00	persiapan asistensi sebelum UTS
15	15	1306381686	1	2	2016-06-17	16:16:00	22:38:00	asistensi/tutorial mata kuliah sebelum UTS
16	16	1406543864	6	4	2015-07-08	18:12:00	22:03:00	mengoreksi
17	17	1406568753	4	2	2016-03-13	08:28:00	16:30:00	rapat membahas tugas
18	18	1406572025	2	3	2016-02-12	08:56:00	15:20:00	persiapan asistensi sebelum UTS
19	19	1437485954	1	1	2016-07-10	12:12:00	22:56:00	asistensi/tutorial mata kuliah sebelum UTS
20	20	1406543864	7	1	2015-11-28	11:22:00	22:01:00	mengawas ujian
21	21	1345675618	5	3	2016-07-20	13:24:00	21:17:00	sit in kelas
22	22	1322230380	3	4	2016-04-02	08:52:00	21:30:00	membuat soal/tugas latihan 1
23	23	1495635098	7	1	2016-06-23	12:35:00	22:16:00	mengawas ujian
24	24	1547724531	5	3	2016-03-12	11:04:00	21:09:00	sit in kelas
25	25	1365223948	6	1	2016-07-06	18:31:00	23:52:00	mengoreksi
26	26	1388445371	7	4	2016-02-12	12:54:00	22:52:00	mengawas ujian
27	27	1310788111	1	1	2015-07-19	21:13:00	23:23:00	asistensi/tutorial mata kuliah sebelum UTS
28	28	1428766349	7	1	2016-02-22	08:53:00	22:20:00	mengawas ujian
29	29	1428658967	3	2	2016-03-19	15:23:00	21:12:00	membuat soal/tugas tugas 1
30	30	1495635098	1	2	2016-06-15	18:46:00	22:11:00	asistensi/tutorial mata kuliah sebelum UTS
31	31	1331286498	7	2	2016-06-09	16:41:00	21:37:00	mengawas ujian
32	32	1480616954	4	2	2016-02-16	18:29:00	21:29:00	rapat membahas tugas
33	33	1306381982	1	3	2016-07-19	08:22:00	09:22:00	asistensi/tutorial mata kuliah sebelum UTS
34	34	1358344759	3	1	2016-07-11	15:35:00	16:35:00	membuat soal/tugas tugas 1
35	35	1359126319	5	3	2016-07-04	16:55:00	18:55:00	sit in kelas
36	36	1386263953	2	1	2016-07-19	17:21:00	18:50:00	persiapan asistensi sebelum UTS
37	37	1352861996	6	3	2016-06-08	12:25:00	13:30:00	mengoreksi
38	38	1364465102	5	2	2016-01-07	10:50:00	21:45:00	sit in kelas
39	39	1504843053	4	2	2016-09-28	11:36:00	21:51:00	rapat membahas tugas
40	40	1437485954	7	4	2015-11-20	13:28:00	14:58:00	mengawas ujian
41	41	1483310896	6	4	2016-07-15	09:50:00	10:10:00	mengoreksi
42	42	1582194861	2	3	2016-01-15	16:21:00	17:23:00	persiapan asistensi sebelum UTS
43	43	1357615465	4	1	2016-07-14	22:22:00	23:22:00	rapat membahas tugas
44	44	1406568753	1	4	2016-09-22	20:10:00	21:57:00	asistensi/tutorial mata kuliah sebelum UTS
45	45	1306381982	2	3	2016-07-07	14:59:00	15:50:00	persiapan asistensi sebelum UTS
46	46	1504843053	7	3	2016-03-03	14:59:00	16:00:00	mengawas ujian
47	47	1406559963	7	3	2016-09-13	08:12:00	23:28:00	mengawas ujian
48	48	1306381881	5	4	2016-04-20	21:21:00	21:36:00	sit in kelas
49	49	1306381931	7	3	2016-03-13	22:09:00	21:22:00	mengawas ujian
50	50	1306381686	7	3	2016-03-25	22:53:00	23:25:00	mengawas ujian
51	51	1504843053	1	3	2016-09-28	13:09:00	23:25:00	asistensi/tutorial mata kuliah sebelum UAS
52	52	1426858859	6	4	2016-02-01	14:51:00	23:24:00	mengoreksi
53	53	1306381931	2	1	2016-07-07	22:11:00	23:56:00	persiapan asistensi sebelum UTS
54	54	1306381686	1	4	2015-07-26	22:05:00	23:54:00	asistensi/tutorial mata kuliah sebelum UAS
55	55	1453920347	2	2	2016-07-10	11:30:00	21:18:00	persiapan asistensi sebelum UTS
56	56	1453689544	2	2	2016-02-04	22:12:00	21:22:00	persiapan asistensi sebelum UTS
57	57	1372154114	6	3	2016-01-23	17:04:00	21:26:00	mengoreksi
58	58	1372154114	6	1	2016-01-08	14:34:00	23:17:00	mengoreksi
59	59	1315099171	2	4	2016-06-04	17:51:00	21:45:00	persiapan asistensi sebelum UTS
60	60	1453920347	4	3	2016-09-25	13:50:00	16:50:00	rapat membahas tugas
61	61	1483717072	2	2	2016-07-16	17:53:00	23:23:00	persiapan asistensi sebelum UTS
62	62	1493494807	1	3	2015-07-20	13:49:00	16:03:00	asistensi/tutorial mata kuliah sebelum UAS
63	63	1480976061	7	4	2016-07-26	17:55:00	23:45:00	mengawas ujian
64	64	1428658967	2	3	2016-09-28	20:44:00	21:13:00	persiapan asistensi sebelum UTS
65	65	1306413252	4	4	2016-07-18	08:27:00	21:33:00	rapat membahas tugas
66	66	1453689544	7	2	2016-07-14	19:27:00	21:14:00	mengawas ujian
67	67	1327230946	5	4	2016-07-19	14:34:00	22:05:00	sit in kelas
68	68	1547724531	1	2	2016-07-09	16:34:00	23:43:00	asistensi/tutorial mata kuliah sebelum UAS
69	69	1372154114	7	2	2016-07-08	22:34:00	21:51:00	mengawas ujian
70	70	1417684658	6	1	2016-02-03	11:56:00	17:00:00	mengoreksi
71	71	1408858242	6	3	2016-02-29	13:16:00	15:20:00	mengoreksi
72	72	1504843053	4	2	2016-02-20	08:37:00	16:30:00	rapat membahas tugas
73	73	1426858859	2	2	2016-11-01	15:34:00	18:10:00	persiapan asistensi sebelum UTS
74	74	1506959924	2	4	2015-07-07	14:44:00	21:45:00	persiapan asistensi sebelum UTS
75	75	1309554205	3	1	2016-07-26	17:48:00	22:53:00	membuat soal/tugas tugas 1
76	76	1306413252	3	3	2016-06-04	17:50:00	21:33:00	membuat soal/tugas tugas 1
77	77	1504843053	1	2	2016-03-20	18:34:00	22:03:00	asistensi/tutorial mata kuliah sebelum UAS
78	78	1567289372	7	4	2016-11-08	09:24:00	21:45:00	mengawas ujian
79	79	1602334345	7	1	2016-07-04	14:22:00	21:19:00	mengawas ujian
80	80	1545529945	6	1	2016-03-31	14:29:00	23:29:00	mengoreksi
81	81	1306381881	4	2	2016-09-10	21:04:00	21:33:00	rapat membahas tugas
82	82	1306381931	4	2	2016-09-18	12:10:00	22:04:00	rapat membahas tugas
83	83	1306381686	7	1	2016-01-01	18:45:00	23:09:00	mengawas ujian
84	84	1306381881	6	4	2016-07-10	08:22:00	23:21:00	mengoreksi
85	85	1306381931	3	3	2016-02-04	10:51:00	22:14:00	membuat soal/tugas tugas 1
86	86	1306381686	7	1	2015-11-20	14:06:00	21:10:00	mengawas ujian
87	87	1597284299	3	1	2016-04-16	12:51:00	21:53:00	membuat soal/tugas tugas 1
88	88	1307826688	2	2	2016-07-08	22:52:00	21:56:00	persiapan asistensi sebelum UTS
89	89	1328358017	5	4	2016-09-24	17:01:00	18:10:00	sit in kelas
90	90	1561473091	6	3	2016-07-16	13:22:00	15:20:00	mengoreksi
91	91	1406559963	3	4	2016-03-05	17:18:00	22:12:00	membuat soal/tugas 2
92	92	1406559963	1	1	2016-11-15	12:07:00	21:39:00	asistensi/tutorial mata kuliah sebelum UAS
93	93	1426858859	7	1	2016-07-15	14:29:00	16:30:00	mengawas ujian
94	94	1406559963	1	1	2016-07-06	22:11:00	21:08:00	asistensi/tutorial mata kuliah sebelum UAS
95	95	1306381881	1	1	2016-07-02	09:43:00	21:30:00	asistensi/tutorial mata kuliah sebelum UAS
96	96	1306381931	2	4	2016-09-25	12:15:00	21:40:00	persiapan asistensi sebelum UAS
97	97	1306381686	4	2	2016-07-07	17:00:00	23:24:00	rapat membahas tugas
98	98	1426858859	6	3	2016-09-21	13:21:00	14:08:00	mengoreksi
99	99	1306381931	4	2	2016-01-24	19:17:00	22:41:00	rapat membahas tugas
100	100	1328358017	7	1	2016-07-29	14:33:00	23:03:00	mengawas ujian
101	101	1561473091	5	2	2015-07-20	21:37:00	21:04:00	sit in kelas
102	102	1483310896	5	3	2016-01-14	12:08:00	21:05:00	sit in kelas
103	103	1306381881	3	1	2015-07-26	15:36:00	21:50:00	membuat soal/tugas 2
104	104	1562679184	4	2	2016-01-10	22:02:00	21:44:00	rapat membahas tugas
105	105	1406543946	2	1	2016-07-06	10:10:00	11:11:00	persiapan asistensi sebelum UAS
106	106	1406543933	6	3	2016-07-24	10:33:00	11:33:00	mengoreksi
107	107	1406559963	7	2	2016-02-01	22:32:00	23:33:00	mengawas ujian
108	108	1306381881	5	1	2015-07-26	11:27:00	12:32:00	sit in kelas
109	109	1406568015	3	4	2016-07-08	17:08:00	18:00:00	membuat soal/tugas 2
110	110	1406566054	1	1	2016-03-19	12:47:00	14:30:00	asistensi/tutorial mata kuliah sebelum UAS
111	111	1307826688	2	3	2015-07-26	15:09:00	16:00:00	persiapan asistensi sebelum UAS
112	112	1328358017	3	1	2016-07-10	21:56:00	22:50:00	membuat soal/tugas 2
113	113	1310159588	1	1	2016-03-25	16:54:00	19:23:00	asistensi/tutorial mata kuliah sebelum UAS
114	114	1427360641	3	4	2016-11-13	18:08:00	20:21:00	membuat soal/tugas 2
115	115	1447036114	1	4	2016-09-29	15:25:00	21:33:00	asistensi/tutorial mata kuliah sebelum UAS
116	116	1406543851	5	1	2015-07-07	11:43:00	22:21:00	sit in kelas
117	117	1406559963	1	2	2016-06-19	21:36:00	22:29:00	asistensi/tutorial mata kuliah sebelum UAS
118	118	1406567536	1	1	2016-07-10	20:27:00	23:13:00	asistensi/tutorial mata kuliah sebelum UAS
119	119	1406623165	7	3	2016-07-24	12:24:00	22:06:00	mengawas ujian
120	120	1406574623	6	1	2016-07-26	19:37:00	23:16:00	mengoreksi
121	121	1406544116	5	3	2016-01-09	17:17:00	22:26:00	sit in kelas
122	122	1406623146	2	1	2016-07-14	11:49:00	17:00:00	persiapan asistensi sebelum UAS
123	123	1506797545	2	4	2016-02-03	11:20:00	15:20:00	persiapan asistensi sebelum UAS
124	124	1406574516	1	1	2016-07-21	13:43:00	15:20:00	asistensi/tutorial mata kuliah sebelum UAS
125	125	1406623240	6	1	2016-07-08	11:58:00	18:10:00	mengoreksi
126	126	1406623442	1	1	2016-03-17	21:13:00	21:40:00	asistensi/tutorial mata kuliah sebelum UAS
127	127	1459300527	3	3	2016-07-23	20:54:00	23:23:00	membuat soal/tugas 2
128	128	1506797545	5	1	2016-03-21	10:00:00	21:42:00	sit in kelas
129	129	1506797596	4	3	2016-07-30	16:18:00	23:27:00	rapat membahas tugas
130	130	1562679184	2	2	2016-03-31	14:05:00	21:55:00	persiapan asistensi sebelum UAS
131	131	1406543946	6	2	2016-03-04	21:49:00	21:36:00	mengoreksi
132	132	1406543933	4	2	2016-01-14	19:11:00	23:00:00	rapat membahas tugas
133	133	1406577064	2	1	2016-09-29	21:21:00	23:38:00	persiapan asistensi sebelum UAS
134	134	1406559963	3	4	2015-07-01	12:35:00	13:35:00	membuat soal/tugas 2
135	135	1310788111	6	3	2016-07-30	13:31:00	14:55:00	mengoreksi
136	136	1426858859	6	2	2016-07-18	17:35:00	19:00:00	mengoreksi
137	137	1310788111	5	4	2015-11-19	11:55:00	12:54:00	sit in kelas
138	138	1306381881	5	1	2016-07-28	11:52:00	16:56:00	sit in kelas
139	139	1433980142	7	4	2016-07-27	10:40:00	11:00:00	mengawas ujian
140	140	1406543933	5	2	2016-06-03	13:37:00	15:00:00	sit in kelas
141	141	1406543946	1	3	2016-06-11	09:55:00	21:36:00	asistensi/tutorial mata kuliah sebelum UAS
142	142	1406559963	6	1	2016-07-11	09:55:00	22:05:00	mengoreksi
143	143	1506797545	1	1	2016-09-21	10:07:00	21:52:00	asistensi/tutorial mata kuliah sebelum UAS
144	144	1406623442	3	4	2016-07-15	11:31:00	22:16:00	membuat soal/tugas 2
145	145	1428766349	2	3	2016-03-14	12:50:00	22:47:00	persiapan asistensi sebelum UAS
146	146	1306381931	3	2	2016-03-05	08:45:00	23:26:00	membuat soal/tugas 3
147	147	1406559963	3	1	2016-01-15	12:54:00	13:54:00	membuat soal/tugas 3
148	148	1406559963	4	2	2016-01-18	15:06:00	17:06:00	rapat membahas tugas
149	149	1426858859	1	3	2016-07-15	17:00:00	17:50:00	asistensi/tutorial mata kuliah sebelum UAS
150	150	1406559963	2	4	2016-01-28	14:15:00	15:15:00	persiapan asistensi sebelum UAS
\.


--
-- Data for Name: lowongan; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY lowongan (idlowongan, idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka, jumlah_pelamar, jlh_pelamar_diterima) FROM stdin;
25	1	t	3		121303010	0	0
33	2	t	1		121303009	0	0
30	3	f	1		121203009	0	0
2	4	f	2		197704182012121003	0	0
7	5	f	5		198704262012121002	0	0
50	6	f	0		196201021992031003	0	0
10	7	f	2		120903014	0	0
1	8	f	1		121113004	0	0
5	9	f	0		121403002	0	0
21	10	f	2		195906171985032002	0	0
32	11	f	5		195304201989031002	0	0
26	12	t	3		121103004	0	0
11	13	f	7		30603001	0	0
23	14	t	3		195903251993111001	0	0
40	15	f	0		121203004	0	0
18	16	f	2		120803003	0	0
44	17	f	2		194901071976031001	0	0
16	18	f	9		1208050380	0	0
15	19	f	7		197603012008121001	0	0
28	20	f	1		1208050382	0	0
3	21	f	3		51-440-8220	0	0
13	22	f	4		61-099-7306	0	0
14	23	t	3		58-361-8873	0	0
4	24	f	4		99-362-9320	0	0
19	25	f	2		80-025-8973	0	0
17	26	t	6		74-969-0531	0	0
20	26	t	2		73-269-0824	0	0
12	27	f	5		42-033-8510	0	0
8	28	f	4		51-914-9425	0	0
6	30	f	0		194901071976031001	0	0
24	31	t	3		195304201989031002	0	0
34	32	t	2		195903251993111001	0	0
9	33	t	3		195906171985032002	0	0
35	34	t	9		196201021992031003	0	0
49	35	t	6		197603012008121001	0	0
46	36	f	3		197704182012121003	0	0
22	37	f	2		198704262012121002	0	0
38	38	f	0		121103004	0	0
36	39	f	0		121113004	0	0
31	40	t	5		121203004	0	0
41	41	t	3		121203009	0	0
43	42	t	1		121303009	0	0
48	43	t	5		121303010	0	0
42	44	f	2		121403002	0	0
27	45	t	1		42-033-8510	0	0
39	46	t	1		51-440-8220	0	0
45	47	t	3		51-914-9425	0	0
47	48	t	4		58-361-8873	0	0
37	49	t	1		61-099-7306	0	0
29	50	t	1		73-269-0824	0	0
51	1	f	1		30603001	0	0
52	2	t	2		195903251993111001	0	0
53	3	t	3		121103004	0	0
54	4	t	3		121303009	0	0
55	5	t	2		121113004	0	0
56	6	t	2		121203004	0	0
57	7	t	1		121203009	0	0
58	8	f	2		121303009	0	0
59	9	t	2		80-025-8973	0	0
60	10	t	2		194901071976031001	0	0
61	22	t	4		74-969-0531	0	0
62	22	f	3		42-033-8510	0	0
63	22	t	2		51-440-8220	0	0
64	29	t	3		121303010	0	0
65	22	t	1		58-361-8873	0	0
\.


--
-- Data for Name: mahasiswa; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY mahasiswa (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) FROM stdin;
1406543851	ABDUL HAKIM	abdul.hakim37	hakim48	abdul.hakim37@abc.ac.id	abdulhakim63@yahoo.com	Senin jam 15-18, Jumat jam 14-18	BCA	1784176300	http://farm3.static.flickr.com/2278/2300491905_5272f77e56.jpg	http://www.cnboxing.com/ddimg/uploadimg/20070805/083708497.jpg
1406559963	ABDUL RAUF P. SALEO	abdul.rauf	raufapril32	abdul.rauf@abc.ac.id	abdulsaleo26@yahoo.com	Selasa jam 17-20, Jumat jam 15	Mandiri	1650040078470	http://www.pic35.com/uploads/allimg/100526/1-100526224U1.jpg	http://space.tv.cctv.com/image/20080710/IMAG1215671983467106.jpg
1406567536	ADAM JORDAN	adam.jordan55	jordan98	adam.jordan55@abc.ac.id	adamjordan82@yahoo.com	Senin-Kamis jam 15-18	BNI	 	http://img.99118.com/Big2/1024768/20101211/1700013.jpg	http://image1.levelup.cn/c/news/images/ef066d01-44f5-4254-92ff-5b35a2e715fe.jpg
1406543864	ADITYA ARAMBANA	aditya.arambana	aditya4	aditya.arambana@abc.ac.id	adityaarambana98@yahoo.com	Rabu&Jumat jam 10-17	BRI	31231720778554	http://farm1.static.flickr.com/45/139488995_bd06578562.jpg	http://www.hotboxingnews.com/images/11mensboxingringside.jpg
1406572025	ADITYA BETA SUTOPO P	aditya.beta	adityabeta96	aditya.beta@abc.ac.id	adityap69@yahoo.com	Selasa dan Kamis jam 15-18	Mandiri	1650060077330	http://farm3.static.flickr.com/2285/2658605078_f409b25597.jpg	http://farm4.static.flickr.com/3055/2600381743_cb8e623d1e.jpg?v=0
1406568753	ADITYAWARMAN FANARO	adityawarman.fanaro	adityawarman92	adityawarman.fanaro@abc.ac.id	 	Kamis jam 10-18	Mandiri	1650030076720	http://farm4.static.flickr.com/3202/2960028736_74d31b947d.jpg	http://static.flickr.com/2315/2248437855_1df1de1cbc.jpg
1306381881	AULIA CHAIRUNISA	aulia.chairunisa	chairunisa90	aulia.chairunisa@abc.ac.id	auliachairunisa34@yahoo.com	Senin jam 10-12,Selasa jam 15-18,Rabu jam 10-16	BNI	5006003054	http://img1.gootrip.com/gootrip/_20upload/mdd/2010-03-10/41078_y3.jpg	http://farm4.static.flickr.com/3170/2788568071_ac1dcd1c46.jpg?v=0
1306381931	CLARA INDRIYANI	clara.indriyani	indriyani61	clara.indriyani@abc.ac.id	claraindriyani98@yahoo.com	Selasa jam 16-18, Rabu jam 16-18	Mandiri	1650080079180	http://hb.xinhuanet.com/photo/2011-01/12/xin_343010812173648424399138.jpg	http://farm1.static.flickr.com/224/460168648_bfb1835fdb.jpg
1306381686	FATIA KUSUMA DEWI	fatia.kusuma	kusuma43	fatia.kusuma@abc.ac.id	fatiadewi63@yahoo.com	Senin jam 10-17, Jumat jam 10-15	BCA	1785383488	 	http://farm4.static.flickr.com/3017/2981547010_1a109aab55.jpg
1306409500	FEBRIYOLA ANASTASIA	febriyola.anastasia	febriyola66	febriyola.anastasia@abc.ac.id	febriyolaanastasia@yahoo.com	Selasa-Jumat jam 14-17	Mandiri	1650010075320	http://farm3.static.flickr.com/2506/3724084193_802ea38fc5.jpg	http://www.tianshui.com.cn/Files204/BeyondPic/2008-8/24/Img259026634.jpg
1306381950	FITHRIANNISA AUGUSTIANTI	fithriannisa.augustianti	fithriannisa53	fithriannisa.augustianti@abc.ac.id	fithriannisa95@yahoo.com	Senin jam 15-17, Selasa jam 16-18, Kamis jam 10-16, Jumat jam 14-17	BNI	8006063062	http://farm4.static.flickr.com/3349/3225698594_b244616b3e.jpg	http://www.optimallifefitness.com/olfblog/uploaded_images/Stevie-Smith-728851.JPG
1306463591	IRVI FIRQOTUL AINI	irvi.firqotul	firqotul86	irvi.firqotul@abc.ac.id	irviaini63@yahoo.com	Jumat jam 14-18	Danamon	3237510885	http://diving.kensuke.net/archives/0025_dumaguete/images/30.jpg	http://cache.daylife.com/imageserve/0eHwgfC8b8c34/610x.jpg
1306381982	ISRA MELA	isra.mela	melappw72	isra.mela@abc.ac.id	isramela77@yahoo.com	Senin jam 15-18, Selasa jam 14-16, Rabu jam 13-16	BCA	1781577231	http://farm3.static.flickr.com/2609/4113927276_33111a2398.jpg	http://www.philboxing.com/news/pix/pac-em2.erik.down..403w.jpg
1506797564	SHAFA SALAMY	shafa.salamy	salamy21	shafa.salamy@abc.ac.id	shafasalamy93@yahoo.com	Kamis jam 16-18, Jumat jam 10-18	BCA	1785678723	http://farm3.static.flickr.com/2179/2090355369_4c8a60f899.jpg	http://static.flickr.com/3335/3254187500_452aa397d5.jpg
1306413252	KEN NABILA SETYA	ken.nabila	nabila95	ken.nabila@abc.ac.id	kensetya57@yahoo.com	Rabu dan Jumat jam 10-18	BNI	3006083006	http://farm4.static.flickr.com/3205/2815917575_c2ea596ed2.jpg	http://www.pep.ph/images/writeups/73b3d6259.jpg
1406544103	MISCHELLE MEILISA	mischelle.meilisa	mischelle77	mischelle.meilisa@abc.ac.id	mischellemeilisa46@gmail.com	Rabu dan Jumat jam 16-18	BNI	4006033018	http://farm3.static.flickr.com/2084/2517885309_6680a79ab1.jpg	http://kwh.monroe.k12.fl.us/Sports/timmy.jpg
1406543933	MONICA AGUSTIN SAVITRI	monica.agustin	monica18	monica.agustin@abc.ac.id	monicasavitri@gmail.com	Kamis jam 10-18	CIMBNiaga	1772562085415	http://farm1.static.flickr.com/81/245539781_42028c8c67.jpg	http://img.v163.56.com/images/29/28/day365flyi56olo56i56.com_zhajm_121043870962x.jpg
1406577064	MUTHIA NABILA	muthia.nabila	muthia26	muthia.nabila@abc.ac.id	muthianabila59@gmail.com	Senin jam 10-12, Selasa jam 16-18, Jumat 14-18	BNI	 	http://farm2.static.flickr.com/1437/680424989_da45c42286.jpg	http://cache.daylife.com/imageserve/04Bn7aq2si7Nt/340x.jpg
1406568015	NOVITA CIAYADI	novita.ciayadi	novita43	novita.ciayadi@abc.ac.id	novitaciayadi58@gmail.com	Rabu jam 16-18, Kamis jam 17-18, Jumat jam 16-18	BCA	1782115028	http://farm1.static.flickr.com/176/441681804_fec8ae4c58.jpg	http://www.akpromotions.org/RickR7%20picture.JPG
1406566054	NURUL INAYAH AB	nurul.inayah44	inayah20	nurul.inayah44@abc.ac.id	 	Kamis jam 15-18, Rabu jam 10-16	BCA	1781755404	http://210.34.136.253:8488/Geoscience/images/Fig5_15.jpg	http://farm4.static.flickr.com/3501/3233406210_08752b4621.jpg
1406544116	POPPY BUANA MEGA PUTRI	poppy.buana	buana13	poppy.buana@abc.ac.id	poppyputri27@gmail.com		CIMB Niaga	1777014484421	http://farm4.static.flickr.com/3549/3320799354_5e8e774cae.jpg	http://www.canbet.com/images/5/en/misc/cbtuk_contentpic_boxing.jpg
1406623146	PRATIWI RAHMATILLISAN	pratiwi.rahmatillisan	pratiwi21	pratiwi.rahmatillisan@abc.ac.id	pratiwirahmatillisan11@gmail.com	Rabu jam 13-16, Kamis jam 16-18	Mandiri	1650040077780	http://farm4.static.flickr.com/3070/3037959914_9b742d6c0c.jpg	http://farm4.static.flickr.com/3189/2981542014_96226706d1.jpg
1406623240	RADEN RARA INTANIA NURHANIFAH	raden.rara	rararaden29	raden.rara@abc.ac.id	radennurhanifah88@gmail.com	Senin-Kamis, jam 10-12	BRI	37003110273352	http://farm1.static.flickr.com/117/294661005_10c1eaff2c.jpg	http://farm3.static.flickr.com/2249/1972567931_b8e34076f7.jpg
1406623442	RATIH AJENG KOMARANINGSIH	ratih.ajeng	ajengkartini21	ratih.ajeng@abc.ac.id	ratihkomaraningsih76@gmail.com	Jumat jam 14-18	Mandiri	1650050070810	http://farm3.static.flickr.com/2202/2826934858_1ca144a945.jpg	http://www.kungfunews.com/kungfu/2008_06/080612184591281.jpg
1406543946	REDITA LISKIYARI	redita.liskiyari	redita69	redita.liskiyari@abc.ac.id	reditaliskiyari57@gmail.com	Senin-Rabu jam 10-16	BNI	1006083067	http://farm3.static.flickr.com/2094/2105128281_0583efdc9b.jpg	http://www.theseats.com/contentimages/Floyd-Mayweather-Jr-6956921.jpg
1406574516	RIDHA AULIA RAHMI	ridha.aulia	aulia52	ridha.aulia@abc.ac.id	ridharahmi69@gmail.com	Selasa-Rabu jam 08-12	Mandiri	 	http://farm1.static.flickr.com/32/54468503_c1e3f9a83c.jpg	http://farm3.static.flickr.com/2203/2668103298_5487524358.jpg
1406623165	RIMA RAKHMAWATI AMALIA	rima.rakhmawati	rakhmawati61	rima.rakhmawati@abc.ac.id	rimaamalia21@gmail.com	Senin jam 15-18, Rabu jam 10-16	BCA	1781552833	http://farm2.static.flickr.com/1317/1174846951_cb6b7d1db9.jpg	http://farm1.static.flickr.com/137/381045278_726b9db47b.jpg
1406574623	RISTYA NINTYANA	ristya.nintyana	ristya13	ristya.nintyana@abc.ac.id	ristyanintyana6@gmail.com	Kamis jam 10-18, Jumat jam 15-18	BNI	4006013075	http://farm4.static.flickr.com/3540/3393170675_4345176050.jpg	http://farm2.static.flickr.com/1374/1486124226_ce6b478941.jpg
1506797545	Rully Ramadhan	rully.ramadhan	ramadhan24	rully.ramadhan@abc.ac.id	rullyramadhan30@gmail.com	Senin jam 14-18, Kamis jam 10-16	Mandiri	1650030074960	http://farm4.static.flickr.com/3202/2939422405_cd6c8ddbba.jpg	http://farm4.static.flickr.com/3127/2875669464_a0e0332f0b.jpg
1506797596	Wisnu Wardhana Mahendra	wisnu.wardhana	wardhana56	wisnu.wardhana@abc.ac.id	wisnumahendra63@gmail.com	Rabu-Jumat jam 16-18	BNI	5006033011	http://farm2.static.flickr.com/1287/538828157_521d9f74d0.jpg	http://farm2.static.flickr.com/1071/1305916989_5fb2db0662.jpg
1459300527	Tammy Simmons	tsimmons0	2nXBHnbVyMP1	tsimmons0@abc.ac.id	tsimmons0@biblegateway.com	Kamis 11:13 - 15:00	Hagenes Inc	30082044896654	http://dummyimage.com/119x234.jpg/5fa2dd/ffffff	http://dummyimage.com/135x224.jpg/ff4444/ffffff
1310159588	Eugene Perez	eperez1	bTJVV23ZU	eperez1@abc.ac.id	eperez1@slashdot.org	Senin 10:59  - 14:00	Collins Inc	3542952456182190	http://dummyimage.com/140x244.jpg/dddddd/000000	http://dummyimage.com/231x153.bmp/ff4444/ffffff
1427360641	Justin Nelson	jnelson2	xNEyB7LIof3B	jnelson2@abc.ac.id	jnelson2@independent.co.uk	Kamis 13:54  - 17:00	Kunze Inc	3550336752496860	http://dummyimage.com/155x106.jpg/dddddd/000000	http://dummyimage.com/222x189.png/5fa2dd/ffffff
1345675618	Michael Andrews	mandrews3	6mveYzh	mandrews3@abc.ac.id	mandrews3@jalbum.net	Selasa 12:35  - 16:00	Hackett, Herman and Schiller	36869509978587	http://dummyimage.com/242x133.bmp/5fa2dd/ffffff	http://dummyimage.com/227x167.jpg/dddddd/000000
1322230380	Nicole Peters	npeters4	QeMdUZ1p	npeters4@abc.ac.id	npeters4@google.com	Rabu 10:03  - 14:00	Hackett LLC	3530802913627730	http://dummyimage.com/140x109.bmp/ff4444/ffffff	http://dummyimage.com/117x221.bmp/cc0000/ffffff
1521338802	Ryan Nguyen	rnguyen5	wlYOriWfk5BA	rnguyen5@abc.ac.id	rnguyen5@feedburner.com	Senin 15:04  - 19:00	Ondricka, Schaden and Cole	3588998807473090	http://dummyimage.com/212x174.jpg/5fa2dd/ffffff	http://dummyimage.com/135x119.jpg/cc0000/ffffff
1310788111	Joyce Green	jgreen6	2bEweK6q	jgreen6@abc.ac.id	jgreen6@sohu.com	Jumat 10:26  - 14:00	Rosenbaum, Reilly and Hagenes	5100145963617690	http://dummyimage.com/244x173.bmp/cc0000/ffffff	http://dummyimage.com/113x198.png/5fa2dd/ffffff
1428766349	Ryan Duncan	rduncan7	IhHWPb49Z	rduncan7@abc.ac.id	rduncan7@rambler.ru	Jumat 15:01  - 19:00	Tromp Group	3560308912617930	http://dummyimage.com/176x163.bmp/5fa2dd/ffffff	http://dummyimage.com/181x206.jpg/5fa2dd/ffffff
1433980142	Peter Nichols	pnichols8	ya4aE5umaAC	pnichols8@abc.ac.id	pnichols8@springer.com	Rabu 10:13  - 14:00	Gutkowski Inc	6763132545148230000	http://dummyimage.com/185x176.png/5fa2dd/ffffff	http://dummyimage.com/110x214.bmp/ff4444/ffffff
1426858859	Jason Brown	jbrown9	UjfnxuSq	jbrown9@abc.ac.id	jbrown9@examiner.com	Kamis 10:34  - 14:00	Feeney, Daugherty and Rowe	30195501557757	http://dummyimage.com/249x222.bmp/ff4444/ffffff	http://dummyimage.com/237x107.jpg/ff4444/ffffff
1562679184	Debra Myers	dmyersa	W45W6Se6x57	dmyersa@abc.ac.id	dmyersa@discuz.net	Jumat 11:32  - 15:00	Williamson Group	3551783604749930	http://dummyimage.com/234x120.png/ff4444/ffffff	http://dummyimage.com/183x226.bmp/5fa2dd/ffffff
1358344759	Jane Sanchez	jsanchezb	dHOvaN	jsanchezb@abc.ac.id	jsanchezb@de.vu	Selasa 8:21  - 12:00	Bartoletti-Labadie	3547034756226060	http://dummyimage.com/132x159.jpg/dddddd/000000	http://dummyimage.com/156x243.jpg/ff4444/ffffff
1352861996	Margaret Cunningham	mcunninghamc	IRTBwVRY	mcunninghamc@abc.ac.id	mcunninghamc@mapy.cz	Rabu 11:51  - 15:00	Becker LLC	6373174010571650	http://dummyimage.com/229x247.jpg/5fa2dd/ffffff	http://dummyimage.com/161x235.bmp/cc0000/ffffff
1364465102	Carolyn Dixon	cdixond	gh3aeqoavGpL	cdixond@abc.ac.id	cdixond@youtu.be	Kamis 11:30  - 15:00	Casper-Hilpert	3586245159711540	http://dummyimage.com/185x158.png/cc0000/ffffff	http://dummyimage.com/185x238.png/cc0000/ffffff
1504843053	George Mcdonald	gmcdonalde	2Zib3I	gmcdonalde@abc.ac.id	gmcdonalde@icq.com	Selasa 11:44  - 15:00	Huels, Lakin and Schmitt	3568569647875810	http://dummyimage.com/109x219.png/cc0000/ffffff	http://dummyimage.com/141x113.jpg/ff4444/ffffff
1437485954	Rachel Oliver	roliverf	C2IfxfzI	roliverf@abc.ac.id	roliverf@gmpg.org	Rabu 13:33  - 17:00	Schroeder Group	5435990650633300	http://dummyimage.com/203x125.jpg/5fa2dd/ffffff	http://dummyimage.com/202x209.bmp/5fa2dd/ffffff
1483310896	Justin Richardson	jrichardsong	gxBdqrSc2ggs	jrichardsong@abc.ac.id	jrichardsong@miibeian.gov.cn	Senin 15:32  - 19:00	Rosenbaum Group	3543521923672360	http://dummyimage.com/101x128.bmp/5fa2dd/ffffff	http://dummyimage.com/135x147.bmp/dddddd/000000
1321360444	Adam Kelley	akelleyh	PyKTzK23o6	akelleyh@abc.ac.id	akelleyh@privacy.gov.au	Senin 8:24  - 12:00	Bauch, Breitenberg and Stracke	201659269142535	http://dummyimage.com/192x176.jpg/5fa2dd/ffffff	http://dummyimage.com/161x130.bmp/5fa2dd/ffffff
1413330966	Sean Castillo	scastilloi	PNGDSJ27	scastilloi@abc.ac.id	scastilloi@icio.us	Senin 10:56  - 14:00	Marvin, Russel and Jakubowski	6334992567849320000	http://dummyimage.com/232x220.jpg/dddddd/000000	http://dummyimage.com/250x189.png/cc0000/ffffff
1358686701	Rachel Long	rlongj	Z1lWTBZP7iw	rlongj@abc.ac.id	rlongj@wp.com	Jumat 15:42  - 19:00	Barton-Bauch	5602239782586480	http://dummyimage.com/246x154.png/dddddd/000000	http://dummyimage.com/119x161.bmp/cc0000/ffffff
1398288328	Robert Brooks	rbrooksk	D77vbAo	rbrooksk@abc.ac.id	rbrooksk@booking.com	Senin 12:56 - 16:00	Eichmann-Daniel	670908276294376000	http://dummyimage.com/194x123.png/dddddd/000000	http://dummyimage.com/205x205.bmp/5fa2dd/ffffff
1417961635	Beverly Fuller	bfullerl	1As95at	bfullerl@abc.ac.id	bfullerl@parallels.com	Senin 14:28 - 18:00	Ledner-Anderson	3548391259906000	http://dummyimage.com/231x145.png/5fa2dd/ffffff	http://dummyimage.com/191x216.jpg/5fa2dd/ffffff
1347530123	Nicole Edwards	nedwardsm	fso4y4FCuC	nedwardsm@abc.ac.id	nedwardsm@digg.com	Kamis 8:03 - 12:00	Wilkinson LLC	3579448922822230	http://dummyimage.com/226x138.jpg/ff4444/ffffff	http://dummyimage.com/194x112.jpg/dddddd/000000
1430852563	Shawn Willis	swillisn	GqwA2VbTTx	swillisn@abc.ac.id	swillisn@dmoz.org	Kamis 12:13 - 16:00	Botsford-Barrows	5610179308828330	http://dummyimage.com/151x199.bmp/ff4444/ffffff	http://dummyimage.com/217x178.png/dddddd/000000
1332621326	Joseph Morales	jmoraleso	fzat9ENIpb	jmoraleso@abc.ac.id	jmoraleso@timesonline.co.uk	Rabu 10:03 - 14:00	Waelchi, OReilly and Wolff	3545503396659190	http://dummyimage.com/246x241.jpg/5fa2dd/ffffff	http://dummyimage.com/220x182.bmp/ff4444/ffffff
1382903208	Norma Stephens	nstephensp	Gt47P4Nbf	nstephensp@abc.ac.id	nstephensp@google.it	Senin 14:51 - 18:00	Hand, Hoppe and Hickle	676178249305227000	http://dummyimage.com/177x143.jpg/5fa2dd/ffffff	http://dummyimage.com/227x139.png/5fa2dd/ffffff
1583589971	Anthony Rice	ariceq	93RvGAk7F	ariceq@abc.ac.id	ariceq@4shared.com	Kamis 9:37 - 13:00	OReilly, Cartwright and Batz	3558260770891070	http://dummyimage.com/140x104.bmp/ff4444/ffffff	http://dummyimage.com/132x200.jpg/dddddd/000000
1392164669	Nicholas Butler	nbutlerr	9WizT6MWS	nbutlerr@abc.ac.id	nbutlerr@over-blog.com	Rabu 13:07 - 17:00	Ward-Metz	372301979776285	http://dummyimage.com/149x110.jpg/dddddd/000000	http://dummyimage.com/185x157.bmp/ff4444/ffffff
1558235521	Terry Ford	tfords	pu8IXYj8DzDt	tfords@abc.ac.id	tfords@about.com	Kamis 13:12 - 17:00	Schmitt, Gleason and Balistreri	4026372954747020	http://dummyimage.com/215x185.png/cc0000/ffffff	http://dummyimage.com/182x103.bmp/cc0000/ffffff
1478268570	Debra Howell	dhowellt	tLCnHkCHYE	dhowellt@abc.ac.id	dhowellt@merriam-webster.com	Jumat 10:24 - 14:00	Oberbrunner, Turcotte and Bahringer	5602226156749390	http://dummyimage.com/138x106.png/dddddd/000000	http://dummyimage.com/146x230.png/cc0000/ffffff
1548540734	Theresa Oliver	toliveru	2HGPC76IiIF	toliveru@abc.ac.id	toliveru@kickstarter.com	Kamis 15:20 - 19:00	Olson-Feil	4903619846725490	http://dummyimage.com/234x151.bmp/cc0000/ffffff	http://dummyimage.com/170x131.bmp/dddddd/000000
1344241167	George Burke	gburkev	nqfnrN4T	gburkev@abc.ac.id	gburkev@cloudflare.com	Selasa 9:20 - 13:00	DuBuque-Schroeder	3564760587014040	http://dummyimage.com/121x127.bmp/cc0000/ffffff	http://dummyimage.com/197x152.bmp/ff4444/ffffff
1553125751	Lillian Palmer	lpalmerw	fIDS6K	lpalmerw@abc.ac.id	lpalmerw@fda.gov	Selasa 10:10 - 14:00	Walter, Trantow and Berge	3560761332002220	http://dummyimage.com/224x114.bmp/cc0000/ffffff	http://dummyimage.com/175x168.bmp/ff4444/ffffff
1330222343	Edward Larson	elarsonx	saKQmZrk	elarsonx@abc.ac.id	elarsonx@cnbc.com	Kamis 9:10 - 13:00	Morissette, Haag and Jakubowski	3547492070871280	http://dummyimage.com/193x153.png/ff4444/ffffff	http://dummyimage.com/107x188.bmp/ff4444/ffffff
1499806376	Joseph Ellis	jellisy	ud9ywVfr	jellisy@abc.ac.id	jellisy@diigo.com	Jumat 12:35 - 16:00	Kilback, Bartoletti and Towne	3554230206440940	http://dummyimage.com/166x158.png/5fa2dd/ffffff	http://dummyimage.com/109x207.bmp/5fa2dd/ffffff
1403738845	Emily Greene	egreenez	emGChHG3Puy	egreenez@abc.ac.id	egreenez@storify.com	Senin 10:25 - 14:00	Cremin and Sons	3561881134590490	http://dummyimage.com/177x144.bmp/ff4444/ffffff	http://dummyimage.com/195x240.png/dddddd/000000
1480976061	Melissa Simmons	msimmons10	gjs0i6yPDpW	msimmons10@abc.ac.id	msimmons10@yandex.ru	Kamis 8:21 - 12:00	Lowe-Grady	5379129639339460	http://dummyimage.com/156x239.bmp/dddddd/000000	http://dummyimage.com/136x123.png/5fa2dd/ffffff
1428658967	John Kim	jkim11	6efEI8	jkim11@abc.ac.id	jkim11@jiathis.com	Jumat 10:47- 14:00	Rohan, Ledner and Kiehn	3538190358088250	http://dummyimage.com/162x104.jpg/dddddd/000000	http://dummyimage.com/200x101.png/dddddd/000000
1495635098	Evelyn Alvarez	ealvarez12	xljUWLJ	ealvarez12@abc.ac.id	ealvarez12@jimdo.com	Kamis 10:31- 14:00	Prohaska LLC	5602253055681110	http://dummyimage.com/150x217.png/ff4444/ffffff	http://dummyimage.com/152x153.jpg/5fa2dd/ffffff
1547724531	Ronald Meyer	rmeyer13	v28wyGP0c	rmeyer13@abc.ac.id	rmeyer13@hao123.com	Selasa 11:46- 15:00	Turner, Beier and Koss	3552526425944770	http://dummyimage.com/132x201.jpg/ff4444/ffffff	http://dummyimage.com/173x203.jpg/ff4444/ffffff
1372154114	Jack Montgomery	jmontgomery14	93teGsN3qWQ	jmontgomery14@abc.ac.id	jmontgomery14@webs.com	Senin 15:02- 19:00	Spinka, Ratke and Larkin	378129524231223	http://dummyimage.com/225x173.png/ff4444/ffffff	http://dummyimage.com/241x146.png/5fa2dd/ffffff
1315099171	Anne Riley	ariley15	7B3aiUdZQsl	ariley15@abc.ac.id	ariley15@imgur.com	Jumat 15:16- 19:00	Runolfsdottir, Goodwin and Towne	3537535464246140	http://dummyimage.com/151x146.bmp/5fa2dd/ffffff	http://dummyimage.com/245x126.png/cc0000/ffffff
1582194861	Aaron Hanson	ahanson16	M8uvFwcK	ahanson16@abc.ac.id	ahanson16@mashable.com	Jumat 12:51 - 16:00	Medhurst Group	3557514313632800	http://dummyimage.com/205x232.bmp/dddddd/000000	http://dummyimage.com/103x201.bmp/dddddd/000000
1357615465	Jose Hunt	jhunt17	kOCIFvVp	jhunt17@abc.ac.id	jhunt17@reddit.com	Senin 9:00-13:00	Beer Group	5602229131270150	http://dummyimage.com/167x171.jpg/dddddd/000000	http://dummyimage.com/247x136.jpg/ff4444/ffffff
1453920347	Wanda Duncan	wduncan18	lVxPJcL	wduncan18@abc.ac.id	wduncan18@spotify.com	Rabu 12:59 - 16:00	Swaniawski, Ledner and Bernhard	63049801192767300	http://dummyimage.com/238x224.png/cc0000/ffffff	http://dummyimage.com/227x203.png/dddddd/000000
1483717072	Nicole Olson	nolson19	AeMzlGCZ	nolson19@abc.ac.id	nolson19@sitemeter.com	Rabu 12:20 - 16:00	Wisoky-Paucek	3544453317228760	http://dummyimage.com/237x122.png/ff4444/ffffff	http://dummyimage.com/249x207.jpg/dddddd/000000
1493494807	Philip Jenkins	pjenkins1a	Pu3eBAkM9P6	pjenkins1a@abc.ac.id	pjenkins1a@adobe.com	Senin 10:35 - 14:00	Kerluke, Wolff and Ward	5610175628477030000	http://dummyimage.com/226x223.bmp/cc0000/ffffff	http://dummyimage.com/203x154.png/cc0000/ffffff
1359126319	Joan Rose	jrose1b	U52obNyZwJM	jrose1b@abc.ac.id	jrose1b@booking.com	Senin 9:22 - 13:00	Stokes-Borer	3558614088484920	http://dummyimage.com/194x175.bmp/ff4444/ffffff	http://dummyimage.com/238x247.jpg/cc0000/ffffff
1386263953	Keith Webb	kwebb1c	TREbuhN0	kwebb1c@abc.ac.id	kwebb1c@flickr.com	Jumat 12:05 - 16:00	Fritsch and Sons	3578145768568730	http://dummyimage.com/245x161.bmp/dddddd/000000	http://dummyimage.com/118x235.jpg/dddddd/000000
1365223948	Willie Mills	wmills1d	wEHr703so	wmills1d@abc.ac.id	wmills1d@utexas.edu	Rabu 8:52 - 12:00	Tremblay, Rippin and Eichmann	633323388194031000	http://dummyimage.com/189x159.jpg/ff4444/ffffff	http://dummyimage.com/140x177.jpg/5fa2dd/ffffff
1388445371	Patrick Morales	pmorales1e	lJc1npGJ	pmorales1e@abc.ac.id	pmorales1e@tiny.cc	Jumat 15:57 - 19:00	Paucek, VonRueden and Harris	3549195070929660	http://dummyimage.com/166x159.png/dddddd/000000	http://dummyimage.com/208x177.jpg/dddddd/000000
1331286498	Michelle Bailey	mbailey1f	hnoqCp	mbailey1f@abc.ac.id	mbailey1f@amazon.de	Selasa 14:19 - 18:00	Cassin Group	4175009945730330	http://dummyimage.com/219x234.bmp/5fa2dd/ffffff	http://dummyimage.com/223x187.jpg/ff4444/ffffff
1480616954	Brandon Ruiz	bruiz1g	LrrVSJWICiQ	bruiz1g@abc.ac.id	bruiz1g@cdc.gov	Senin 9:27 - 13:00	OKeefe, Christiansen and Hartmann	4017950940080	http://dummyimage.com/186x164.png/dddddd/000000	http://dummyimage.com/241x107.jpg/dddddd/000000
1566063521	Jane Elliott	jelliott1h	fG7pvbUOaQA	jelliott1h@abc.ac.id	jelliott1h@google.cn	Senin 11:59 - 15:00	King-Wunsch	5108755983757450	http://dummyimage.com/212x154.png/cc0000/ffffff	http://dummyimage.com/193x209.jpg/cc0000/ffffff
1361991771	Julia Holmes	jholmes1i	25kNWY48x	jholmes1i@abc.ac.id	jholmes1i@eepurl.com	Rabu 10:32 - 14:00	Jacobs-Simonis	3571991715375430	http://dummyimage.com/222x104.png/ff4444/ffffff	http://dummyimage.com/186x173.jpg/dddddd/000000
1453689544	Joyce Richardson	jrichardson1j	13fr08P6	jrichardson1j@abc.ac.id	jrichardson1j@mysql.com	Jumat 14:48 - 18:00	Herzog-Pollich	3545579000949920	http://dummyimage.com/134x210.png/ff4444/ffffff	http://dummyimage.com/237x128.jpg/ff4444/ffffff
1327230946	Sara Thomas	sthomas1k	dFmuFN6M	sthomas1k@abc.ac.id	sthomas1k@tumblr.com	Senin 14:58 - 18:00	Waelchi-Crona	3569774673523380	http://dummyimage.com/134x161.png/ff4444/ffffff	http://dummyimage.com/222x200.png/cc0000/ffffff
1567289372	Tammy Collins	tcollins1l	4dPRd91u	tcollins1l@abc.ac.id	tcollins1l@twitpic.com	Jumat 8:33 - 12:00	Morar, Abernathy and Friesen	4026473020550220	http://dummyimage.com/245x104.png/ff4444/ffffff	http://dummyimage.com/160x236.bmp/cc0000/ffffff
1602334345	Joseph Morgan	jmorgan1m	rAyBtxf1Yl	jmorgan1m@abc.ac.id	jmorgan1m@i2i.jp	Rabu 9:17 - 13:00	Grant, Wilkinson and Erdman	5048373431869130	http://dummyimage.com/102x186.png/5fa2dd/ffffff	http://dummyimage.com/233x225.png/ff4444/ffffff
1545529945	Keith Moore	kmoore1n	HukYXrQJPEA	kmoore1n@abc.ac.id	kmoore1n@ning.com	Kamis 15:25 - 19:00	Klocko-Muller	3582545611624910	http://dummyimage.com/157x189.bmp/ff4444/ffffff	http://dummyimage.com/164x175.jpg/ff4444/ffffff
1417684658	Dorothy Campbell	dcampbell1o	GHv8xWll	dcampbell1o@abc.ac.id	dcampbell1o@tripod.com	Senin 15:56 - 19:00	Schiller, Emard and Monahan	3586304651803980	http://dummyimage.com/155x247.png/ff4444/ffffff	http://dummyimage.com/146x243.png/dddddd/000000
1408858242	Andrea Cole	acole1p	cJ3qMAZ	acole1p@abc.ac.id	acole1p@istockphoto.com	Selasa 12:30 - 16:00	Gulgowski and Sons	30138520913767	http://dummyimage.com/151x217.png/5fa2dd/ffffff	http://dummyimage.com/169x156.jpg/5fa2dd/ffffff
1506959924	Victor Mcdonald	vmcdonald1q	MN885u81yb	vmcdonald1q@abc.ac.id	vmcdonald1q@twitter.com	Selasa 10:30 - 14:00	Runolfsdottir, Haley and Dicki	4903697863279340000	http://dummyimage.com/115x204.jpg/5fa2dd/ffffff	http://dummyimage.com/101x162.bmp/cc0000/ffffff
1309554205	Diane Hunt	dhunt1r	lpsyRj5aioj	dhunt1r@abc.ac.id	dhunt1r@newyorker.com	Jumat 11:48 - 15:00	Roob, Deckow and Davis	30403184067478	http://dummyimage.com/229x100.bmp/5fa2dd/ffffff	http://dummyimage.com/236x193.png/ff4444/ffffff
1307826688	Willie Watkins	wwatkins1s	BeHwBIA	wwatkins1s@abc.ac.id	wwatkins1s@spotify.com	Kamis 15:17 - 19:00	Ortiz, Kunze and Rippin	6376537904301140	http://dummyimage.com/238x144.bmp/cc0000/ffffff	http://dummyimage.com/249x142.jpg/5fa2dd/ffffff
1328358017	Robert Day	rday1t	M9tXM7mHTj	rday1t@abc.ac.id	rday1t@discuz.net	Kamis 14:11 - 18:00	Trantow-Stroman	374622828709195	http://dummyimage.com/158x244.png/ff4444/ffffff	http://dummyimage.com/182x216.png/cc0000/ffffff
1561473091	Randy Clark	rclark1u	qAxMk4	rclark1u@abc.ac.id	rclark1u@google.fr	Senin 9:31 - 13:00	Parker LLC	3586787213273870	http://dummyimage.com/242x100.png/cc0000/ffffff	http://dummyimage.com/182x225.bmp/ff4444/ffffff
1597284299	Todd Young	tyoung1v	wU50ZV	tyoung1v@abc.ac.id	tyoung1v@ustream.tv	Selasa 11:56 - 15:00	Lemke LLC	6393545290055140	http://dummyimage.com/162x155.png/5fa2dd/ffffff	http://dummyimage.com/228x174.png/ff4444/ffffff
1309464866	Aaron Franklin	afranklin1w	FazKOFcMq8	afranklin1w@abc.ac.id	afranklin1w@blinklist.com	Rabu 10:11 - 14:00	Emard-Moen	3548496865033070	http://dummyimage.com/209x212.png/5fa2dd/ffffff	http://dummyimage.com/164x130.jpg/cc0000/ffffff
1447036114	Donna Lawrence	dlawrence1x	hEer09tT1al	dlawrence1x@abc.ac.id	dlawrence1x@ow.ly	Rabu 14:06 - 18:00	Maggio, Erdman and Sanford	3574489693855810	http://dummyimage.com/131x132.jpg/dddddd/000000	http://dummyimage.com/144x105.jpg/ff4444/ffffff
1388027963	Craig Collins	pnichols0	fAo5WUkPofv	mlane0@berkeley.edu	khughes0@flickr.com	Senin 12:56 - 17.00	BCA	246506346872523	http://dummyimage.com/127x111.png/cc0000/ffffff	http://dummyimage.com/143x50.png/dddddd/000000
1337538901	Anna Castillo	pwebb1	lUiMpGHgM	djohnston1@over-blog.com	cnichols1@opera.com	Selasa 13.45 -  17.00	Mandiri	573516432202332	http://dummyimage.com/214x162.bmp/cc0000/ffffff	http://dummyimage.com/104x221.jpg/cc0000/ffffff
1372872852	Kimberly Lane	mgardner2	SX1q6nRC	edean2@mail.ru	ewatkins2@facebook.com	Jumat 08.00 - 17.00	BNI	984147771103087	http://dummyimage.com/117x187.png/dddddd/000000	http://dummyimage.com/203x90.jpg/cc0000/ffffff
1468414956	Theresa Green	jthompson3	oKExYj91k1ky	mreid3@latimes.com	jreynolds3@google.com.br	Rabu 12.00 - 18.00	BRI	269233224085264	http://dummyimage.com/150x249.bmp/dddddd/000000	http://dummyimage.com/227x171.jpg/ff4444/ffffff
1340518902	Howard Greene	swatson4	QdSOPJ7d	jrice4@w3.org	pfranklin4@live.com	Senin 9:22 - 13:00	Mandiri	547968614060382	http://dummyimage.com/134x135.jpg/5fa2dd/ffffff	http://dummyimage.com/153x89.bmp/cc0000/ffffff
1455808516	Marilyn Moreno	bwatson5	HcXMA0	agutierrez5@scribd.com	mbanks5@apache.org	Jumat 12:05 - 16:00	Mandiri	382737285999451	http://dummyimage.com/192x183.jpg/cc0000/ffffff	http://dummyimage.com/131x239.png/cc0000/ffffff
1483909222	Daniel Hart	kgilbert6	j9VFV5P8	twilson6@goo.ne.jp	jward6@tamu.edu	Rabu 8:52 - 12:00	BNI	905063942818468	http://dummyimage.com/221x189.jpg/cc0000/ffffff	http://dummyimage.com/206x97.jpg/5fa2dd/ffffff
1442995011	Jessica Perry	acooper7	rN864JrdiX8	jford7@kickstarter.com	dwelch7@economist.com	Jumat 15:57 - 19:00	Mandiri	941509710397727	http://dummyimage.com/148x243.bmp/dddddd/000000	http://dummyimage.com/231x133.bmp/dddddd/000000
1445404545	Carolyn Mason	lcoleman8	KQDLgDvqu1L	asims8@vistaprint.com	lwelch8@mit.edu	Selasa 14:19 - 18:00	BCA	908101554518686	http://dummyimage.com/118x243.png/5fa2dd/ffffff	http://dummyimage.com/124x100.bmp/5fa2dd/ffffff
1323106098	Maria Clark	palexander9	UWMjvQPyz	cfranklin9@aol.com	dwatkins9@sitemeter.com	Senin 9:22 - 13:00	Mandiri	585695446594917	http://dummyimage.com/151x199.bmp/cc0000/ffffff	http://dummyimage.com/106x55.jpg/dddddd/000000
1437594508	Joan Robertson	bcolea	GhC7qK	mshawa@over-blog.com	hbella@bravesites.com	Jumat 12:05 - 16:00	BNI	976127823916315	http://dummyimage.com/136x131.png/dddddd/000000	http://dummyimage.com/125x140.jpg/cc0000/ffffff
1465594057	Henry Wagner	cburnsb	GrVyuIJ0JO	preedb@simplemachines.org	rgardnerb@drupal.org	Rabu 8:52 - 12:00	Danamon	404464629755222	http://dummyimage.com/181x158.bmp/cc0000/ffffff	http://dummyimage.com/140x176.png/cc0000/ffffff
1399304249	Steve Arnold	vdavisc	TPFmqoEBenFh	kfullerc@purevolume.com	cperkinsc@comsenz.com	Jumat 15:57 - 19:00	BCA	365987371166816	http://dummyimage.com/141x221.png/ff4444/ffffff	http://dummyimage.com/106x237.png/cc0000/ffffff
1358794561	Andrew Murphy	staylord	RLGorO	asmithd@ask.com	hbanksd@businessweek.com	Selasa 14:19 - 18:00	BCA	944981644346297	http://dummyimage.com/169x246.png/dddddd/000000	http://dummyimage.com/164x90.png/5fa2dd/ffffff
1345046752	Lisa Duncan	ageorgee	19VqYT	acolee@senate.gov	pscotte@stanford.edu	Senin 9:27 - 13:00	BNI	234315040046521	http://dummyimage.com/179x210.bmp/dddddd/000000	http://dummyimage.com/180x150.jpg/5fa2dd/ffffff
1435823175	Alan Harvey	fjohnsonf	shpX7k0rCo	jjamesf@cdbaby.com	aschmidtf@photobucket.com	Senin 11:59 - 15:00	BNI	944798623122980	http://dummyimage.com/244x154.png/5fa2dd/ffffff	http://dummyimage.com/212x180.bmp/ff4444/ffffff
1419454465	Bruce Barnes	rgibsong	7SQ3Vh	erussellg@soup.io	awelchg@geocities.jp	Rabu 10:32 - 14:00	CIMBNiaga	329118490508267	http://dummyimage.com/111x180.png/dddddd/000000	http://dummyimage.com/245x164.png/dddddd/000000
1349600972	Chris Howell	echapmanh	wXTCTWMR	gmurphyh@imgur.com	tsanchezh@mac.com	Jumat 14:48 - 18:00	BNI	92189312734725	http://dummyimage.com/171x233.png/dddddd/000000	http://dummyimage.com/106x178.bmp/5fa2dd/ffffff
1407877875	Roger Ryan	ayoungi	YJ01iVy	rwardi@dmoz.org	jhawkinsi@example.com	Senin 14:58 - 18:00	BCA	700737058922189	http://dummyimage.com/162x193.png/cc0000/ffffff	http://dummyimage.com/158x125.bmp/5fa2dd/ffffff
1471087845	Gerald Chavez	jbellj	SfkoVYfLKF	bwatsonj@delicious.com	mfranklinj@blogspot.com	Senin 10:25 - 14:00	BCA	312078507812980	http://dummyimage.com/238x239.bmp/cc0000/ffffff	http://dummyimage.com/192x129.jpg/ff4444/ffffff
1445384043	Debra Evans	afoxk	OagU5u	sbanksk@berkeley.edu	ncampbellk@netscape.com	Kamis 8:21 - 12:00	CIMB Niaga	549866614970782	http://dummyimage.com/111x123.png/ff4444/ffffff	http://dummyimage.com/204x163.jpg/5fa2dd/ffffff
1499583126	Frances Lopez	lromerol	OUiDV7Sbvqn	gandersonl@cdc.gov	cfowlerl@wikia.com	Jumat 10:47- 14:00	Mandiri	259033637018596	http://dummyimage.com/213x236.jpg/ff4444/ffffff	http://dummyimage.com/208x54.bmp/cc0000/ffffff
1448626542	Jean Perez	avasquezm	RtKtD6ZeMZ	dfrazierm@desdev.cn	sromerom@msn.com	Kamis 10:31- 14:00	Klocko-Muller	418562575640915	http://dummyimage.com/214x226.bmp/ff4444/ffffff	http://dummyimage.com/232x189.bmp/5fa2dd/ffffff
1421144550	Elizabeth James	ggordonn	w3D962Lvodb3	belliottn@nytimes.com	jhansonn@photobucket.com	Selasa 11:46- 15:00	Schiller, Emard and Monahan	280741819102698	http://dummyimage.com/229x221.jpg/5fa2dd/ffffff	http://dummyimage.com/111x62.jpg/ff4444/ffffff
1419822263	Doris Spencer	jmorgano	I7wuTacY	rcrawfordo@last.fm	kharveyo@blogs.com	Senin 15:02- 19:00	Gulgowski and Sons	123987660454079	http://dummyimage.com/214x220.png/dddddd/000000	http://dummyimage.com/142x178.bmp/ff4444/ffffff
\.


--
-- Data for Name: mata_kuliah; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY mata_kuliah (kode, nama, prasyarat_dari) FROM stdin;
CSGE602040	Struktur Data & Algoritma	CSIM603026
CSIM603026	Pemrograman Skala Perusahaan	CSIM603229
CSIM603229	Proyek Pengembangan Sistem Informasi	RANDOM0001
CSIM601251	Dasar-dasar Arsitektur Komputer	CSGE602055
CSGE602055	Sistem Operasi	CSIM603154
CSIM603154	Jaringan Komunikasi Data	RANDOM0002
CSIM602160	Administrasi Bisnis	CSIM602266
CSIM602266	Sistem Informasi Akuntansi Keuangan	RANDOM0003
CSGE603291	Metodologi Penelitian & Penulisan Ilmiah	CSGE604099
CSGE604099	Tugas Akhir	RANDOM0004
RANDOM0001	Basis Data Lanjut	RANDOM0028
RANDOM0002	Manajemen Layanan TI	RANDOM0029
RANDOM0003	Administrasi Sistem	RANDOM0030
RANDOM0004	Manajemen Infrastruktur TI	RANDOM0031
RANDOM0005	Technopreneurship	RANDOM0032
RANDOM0006	Teknologi Mobile	RANDOM0033
RANDOM0007	Manajemen Keamanan Informasi	RANDOM0034
RANDOM0008	Dasar-dasar Audit SI	RANDOM0035
RANDOM0009	Perdagangan Elektronik	RANDOM0036
RANDOM0010	Kesehatan Elektronik	RANDOM0037
RANDOM0011	Konfigurasi ERP	RANDOM0038
RANDOM0012	Manajemen Pengetahuan	RANDOM0039
RANDOM0013	Analitika Media Sosial	RANDOM0040
RANDOM0014	Penambangan Data & Inteligensia Bisnis	RANDOM0001
RANDOM0015	Pengelolaan Data Besar	RANDOM0002
RANDOM0016	Sistem Informasi Sumber Daya Manusia	RANDOM0003
RANDOM0017	Manajemen Hubungan Pelanggan	RANDOM0004
RANDOM0018	Manajemen Rantai Suplai	RANDOM0005
RANDOM0019	Komputer & Masyarakat	RANDOM0006
RANDOM0020	Kerja Praktik	RANDOM0007
RANDOM0021	Manajemen Sistem Informasi	RANDOM0008
RANDOM0022	Statistika Terapan	RANDOM0009
RANDOM0023	Komunikasi Bisnis dan Teknis	RANDOM0010
RANDOM0024	Manajemen Proyek TI	RANDOM0011
RANDOM0025	Analisis dan Perancangan Sistem Informasi	RANDOM0012
RANDOM0026	Sistem Interaksi	RANDOM0013
RANDOM0027	Sistem-Sistem Perusahaan	RANDOM0014
RANDOM0028	Aljabar Linear	RANDOM0015
RANDOM0029	MPK Agama	RANDOM0016
RANDOM0030	Perancangan & Pemrograman Web	RANDOM0017
RANDOM0031	MPK Seni & Olahraga	RANDOM0018
RANDOM0032	Matematika Diskrit 2	RANDOM0019
RANDOM0033	Fisika Dasar 1	RANDOM0020
RANDOM0034	Kimia	RANDOM0021
RANDOM0035	Biologi	RANDOM0022
RANDOM0036	Geografi	RANDOM0023
RANDOM0037	Ekonomi	RANDOM0024
RANDOM0038	Sejarah	RANDOM0025
RANDOM0039	Sosiologi	RANDOM0026
RANDOM0040	Fisika Dasar 2	RANDOM0027
\.


--
-- Data for Name: mhs_mengambil_kelas_mk; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY mhs_mengambil_kelas_mk (npm, idkelasmk, nilai) FROM stdin;
1406543851	50	89.00
1406559963	2	78.00
1406567536	3	90.00
1406543864	3	87.00
1406572025	2	87.00
1406568753	4	94.00
1306381881	8	87.00
1306381931	46	86.00
1306381686	3	88.00
1306409500	36	79.00
1306381950	43	78.00
1306463591	4	76.00
1306381982	33	80.00
1506797564	42	87.00
1306413252	5	81.00
1406544103	34	86.00
1406543933	38	65.00
1406577064	7	89.00
1406568015	49	91.00
1406566054	12	69.00
1406544116	8	91.00
1406623146	34	70.00
1406623240	32	88.00
1406623442	34	75.00
1406543946	23	76.00
1406574516	12	82.00
1406623165	34	83.00
1406574623	12	81.00
1506797545	34	84.00
1506797596	22	85.00
1406543864	26	86.00
1406623165	10	81.00
1306381881	11	80.00
1406572025	15	82.00
1406559963	14	84.00
1406572025	26	73.00
1506797596	43	86.00
1406543864	21	87.00
1306381686	21	76.00
1406574623	1	75.00
1406567536	19	74.00
1406567536	29	78.00
1406567536	37	79.00
1306463591	50	65.00
1406567536	39	92.00
1406623442	25	49.00
1306409500	21	81.00
1406567536	28	87.00
1406559963	25	70.00
1406543851	12	80.00
1406559963	20	63.00
1406567536	24	76.00
1406543864	13	82.00
1406572025	32	88.00
1406568753	31	77.00
1306381881	3	69.00
1306381931	4	68.00
1306381686	1	80.00
1306409500	8	72.00
1306381950	6	64.00
1306463591	10	74.00
1306381982	7	63.00
1506797564	46	88.00
1306413252	9	74.00
1406544103	18	78.00
1406543933	16	79.00
1406577064	38	65.00
1406568015	30	68.00
1406566054	23	77.00
1406544116	19	67.00
1406623146	39	87.00
1406623240	42	87.00
1406623442	43	80.00
1406543946	17	75.00
1406574516	35	67.00
1406623165	40	76.00
1406574623	36	77.00
1506797545	45	80.00
1506797596	47	86.00
1406543864	14	83.00
1406623165	41	69.00
1306381881	5	65.00
1406572025	33	89.00
1406559963	21	56.00
1406572025	34	77.00
1506797596	48	82.00
1406543864	15	86.00
1306381686	2	67.00
1406574623	37	88.00
1406567536	25	90.00
1406567536	26	77.00
1406567536	27	71.00
1306463591	11	76.00
1406567536	50	59.00
1406623442	44	80.00
1306409500	9	73.00
1406567536	1	69.00
1406559963	22	65.00
1406623442	48	89.00
1459300527	39	78.00
1310159588	5	90.00
1427360641	25	87.00
1345675618	21	87.00
1322230380	12	94.00
1521338802	15	87.00
1310788111	7	86.00
1428766349	29	88.00
1433980142	31	79.00
1426858859	22	78.00
1562679184	23	76.00
1358344759	27	80.00
1352861996	24	87.00
1364465102	34	81.00
1504843053	12	86.00
1437485954	33	65.00
1483310896	4	89.00
1321360444	10	91.00
1413330966	50	69.00
1358686701	29	91.00
1398288328	45	70.00
1417961635	21	88.00
1347530123	22	75.00
1430852563	30	76.00
1332621326	18	82.00
1382903208	39	83.00
1583589971	29	81.00
1392164669	44	84.00
1558235521	21	85.00
1478268570	40	86.00
1548540734	19	81.00
1344241167	19	80.00
1553125751	20	82.00
1330222343	15	84.00
1499806376	11	73.00
1403738845	47	86.00
1480976061	3	87.00
1428658967	26	76.00
1495635098	9	75.00
1547724531	17	74.00
1372154114	37	78.00
1315099171	8	79.00
1582194861	27	65.00
1357615465	26	92.00
1453920347	36	80.00
1483717072	5	81.00
1493494807	7	82.00
1359126319	30	83.00
1386263953	40	84.00
1365223948	35	85.00
1388445371	42	86.00
1331286498	16	87.00
1480616954	1	88.00
1566063521	25	89.00
1361991771	32	90.00
1453689544	35	91.00
1327230946	13	92.00
1567289372	26	93.00
1602334345	31	64.00
1545529945	16	65.00
1417684658	20	66.00
1408858242	49	67.00
1506959924	13	68.00
1309554205	3	69.00
1307826688	1	70.00
1328358017	14	71.00
1561473091	22	72.00
1478268570	30	73.00
1548540734	2	74.00
1344241167	34	75.00
1553125751	38	76.00
1330222343	4	77.00
1499806376	24	78.00
1403738845	20	79.00
1480976061	11	80.00
1428658967	14	81.00
1495635098	6	82.00
1547724531	28	83.00
1372154114	32	84.00
1315099171	23	85.00
1582194861	24	86.00
1357615465	28	87.00
1453920347	23	78.00
1483717072	33	79.00
1493494807	46	80.00
1359126319	2	81.00
1386263953	27	82.00
1365223948	10	83.00
1388445371	18	84.00
1331286498	38	85.00
1480616954	9	86.00
1566063521	28	87.00
1361991771	25	88.00
1453689544	37	89.00
1327230946	6	90.00
1567289372	8	91.00
1602334345	5	92.00
1545529945	41	93.00
1417684658	36	94.00
1408858242	43	95.00
1506959924	17	89.00
\.


--
-- Data for Name: status_lamaran; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY status_lamaran (id, status) FROM stdin;
1	melamar
2	direkomendasikan
3	diterima
4	ditolak
\.


--
-- Data for Name: status_log; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY status_log (id, status) FROM stdin;
1	dilaporkan
2	disetujui
3	ditolak
4	diproses
\.


--
-- Data for Name: telepon_mahasiswa; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY telepon_mahasiswa (npm, nomortelepon) FROM stdin;
1406543851	7-(361)629-7807
1406559963	52-(793)336-1456
1406567536	63-(847)133-6892
1406543864	48-(791)332-8922
1406572025	380-(794)879-7253
1406568753	86-(316)454-8603
1306381881	34-(271)478-6497
1306381931	62-(567)495-8697
1306381686	86-(293)296-2544
1306409500	20-(922)366-1108
1306381950	86-(911)993-3202
1306463591	7-(236)176-8895
1306381982	62-(655)287-7203
1506797564	46-(997)411-0439
1306413252	63-(534)958-8489
1406544103	93-(884)779-8915
1406543933	1-(883)337-5416
1406577064	1-(980)196-0537
1406568015	351-(795)615-0590
1406566054	51-(658)711-6459
1406544116	966-(524)420-9417
1406623146	95-(344)644-9890
1406623240	55-(898)726-3350
1406623442	86-(374)743-2802
1406543946	81-(864)533-5388
1406574516	7-(412)746-7908
1406623165	994-(901)771-4701
1406574623	86-(116)651-2610
1506797545	86-(685)395-5520
1506797596	86-(689)317-1323
1459300527	48-(348)920-8146
1310159588	385-(160)113-0929
1427360641	46-(323)907-7921
1345675618	51-(291)410-4660
1322230380	63-(315)433-3128
1521338802	62-(129)725-8485
1310788111	976-(698)473-4507
1428766349	86-(355)676-4595
1433980142	62-(127)449-3389
1426858859	49-(411)988-9275
1562679184	57-(976)690-9787
1358344759	86-(610)670-2256
1352861996	380-(986)758-1875
1364465102	86-(757)298-0322
1504843053	27-(188)974-3239
1437485954	1-(620)306-3630
1483310896	33-(900)859-6469
1321360444	86-(943)442-9581
1413330966	1-(296)540-9991
1358686701	353-(538)757-0994
1398288328	86-(793)848-9072
1417961635	86-(106)975-1156
1347530123	502-(202)607-6508
1430852563	31-(427)141-9458
1332621326	216-(501)574-8066
1382903208	7-(482)359-2537
1583589971	86-(871)901-4222
1392164669	1-(253)362-8706
1558235521	7-(972)540-7103
1478268570	7-(794)855-7851
1548540734	46-(282)240-0297
1344241167	972-(204)136-5410
1553125751	46-(382)811-9715
1330222343	7-(871)986-2933
1499806376	420-(622)370-9811
1403738845	62-(127)104-2414
1480976061	63-(536)432-8814
1428658967	691-(724)798-8729
1495635098	359-(801)131-9691
1547724531	63-(701)978-7994
1372154114	66-(762)860-0485
1315099171	52-(455)560-0594
1582194861	86-(988)678-2636
1357615465	54-(434)390-9017
1453920347	1-(971)163-7125
1483717072	52-(594)216-1276
1493494807	7-(228)939-3101
1359126319	86-(995)705-5456
1386263953	62-(727)522-9184
1365223948	86-(250)794-7821
1388445371	7-(879)922-5324
1331286498	51-(412)770-1169
1480616954	27-(199)131-0924
1566063521	371-(678)864-1211
1361991771	225-(780)406-2915
1453689544	62-(759)274-5702
1327230946	237-(914)249-1272
1567289372	86-(373)166-9333
1602334345	7-(423)589-4555
1545529945	227-(868)637-7045
1417684658	84-(149)278-1639
1408858242	86-(955)398-9705
1506959924	351-(366)986-6105
1309554205	62-(712)505-1062
1307826688	62-(134)227-4528
1328358017	51-(946)794-7565
1561473091	84-(174)876-1123
1597284299	86-(253)471-8863
1309464866	229-(773)833-3133
1447036114	82-(184)844-9675
1388027963	82-(184)844-9675
1337538901	62-(716)650-1309
1372872852	7-(736)322-5624
1468414956	380-(959)595-0774
1340518902	62-(203)510-3082
1455808516	57-(154)834-4845
1483909222	55-(803)725-2218
1442995011	81-(782)219-4166
1445404545	86-(249)578-4923
1323106098	46-(933)255-5540
1437594508	51-(371)994-3145
1465594057	1-(526)303-4039
1399304249	51-(703)296-2617
1358794561	55-(670)834-1067
1345046752	502-(197)338-2427
1435823175	86-(271)635-6497
1419454465	387-(759)349-8194
1349600972	261-(496)903-1188
1407877875	86-(290)298-4843
1471087845	966-(888)279-9628
1445384043	62-(876)114-8188
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: siasisten; Owner: asa.fairuz
--

COPY term (tahun, semester) FROM stdin;
2014	1
2015	2
2016	3
\.


--
-- Name: dosen_kelas_mk_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY dosen_kelas_mk
    ADD CONSTRAINT dosen_kelas_mk_pkey PRIMARY KEY (nip, idkelasmk);


--
-- Name: dosen_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (nip);


--
-- Name: kategori_log_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY kategori_log
    ADD CONSTRAINT kategori_log_pkey PRIMARY KEY (id);


--
-- Name: kelas_mk_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY kelas_mk
    ADD CONSTRAINT kelas_mk_pkey PRIMARY KEY (idkelasmk);


--
-- Name: lamaran_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_pkey PRIMARY KEY (idlamaran, npm);


--
-- Name: log_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_pkey PRIMARY KEY (idlog);


--
-- Name: lowongan_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_pkey PRIMARY KEY (idlowongan);


--
-- Name: mahasiswa_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY mahasiswa
    ADD CONSTRAINT mahasiswa_pkey PRIMARY KEY (npm);


--
-- Name: mata_kuliah_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY mata_kuliah
    ADD CONSTRAINT mata_kuliah_pkey PRIMARY KEY (kode);


--
-- Name: mhs_mengambil_kelas_mk_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY mhs_mengambil_kelas_mk
    ADD CONSTRAINT mhs_mengambil_kelas_mk_pkey PRIMARY KEY (npm, idkelasmk);


--
-- Name: status_lamaran_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY status_lamaran
    ADD CONSTRAINT status_lamaran_pkey PRIMARY KEY (id);


--
-- Name: status_log_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY status_log
    ADD CONSTRAINT status_log_pkey PRIMARY KEY (id);


--
-- Name: telepon_mahasiswa_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY telepon_mahasiswa
    ADD CONSTRAINT telepon_mahasiswa_pkey PRIMARY KEY (npm);


--
-- Name: term_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: asa.fairuz; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (tahun, semester);


--
-- Name: tr_jlh_pelamar_diterima; Type: TRIGGER; Schema: siasisten; Owner: asa.fairuz
--

CREATE TRIGGER tr_jlh_pelamar_diterima AFTER INSERT OR UPDATE ON lamaran FOR EACH ROW EXECUTE PROCEDURE hitung_jlh_pelamar_diterima();


--
-- Name: trigger_jumlah_pelamar; Type: TRIGGER; Schema: siasisten; Owner: asa.fairuz
--

CREATE TRIGGER trigger_jumlah_pelamar AFTER INSERT ON lamaran FOR EACH ROW EXECUTE PROCEDURE tambah_jumlah_pelamar();


--
-- Name: dosen_kelas_mk_idkelasmk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY dosen_kelas_mk
    ADD CONSTRAINT dosen_kelas_mk_idkelasmk_fkey FOREIGN KEY (idkelasmk) REFERENCES kelas_mk(idkelasmk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dosen_kelas_mk_nip_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY dosen_kelas_mk
    ADD CONSTRAINT dosen_kelas_mk_nip_fkey FOREIGN KEY (nip) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: kelas_mk_kode_mk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY kelas_mk
    ADD CONSTRAINT kelas_mk_kode_mk_fkey FOREIGN KEY (kode_mk) REFERENCES mata_kuliah(kode) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: kelas_mk_tahun_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY kelas_mk
    ADD CONSTRAINT kelas_mk_tahun_fkey FOREIGN KEY (tahun, semester) REFERENCES term(tahun, semester) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lamaran_id_st_lamaran_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_id_st_lamaran_fkey FOREIGN KEY (id_st_lamaran) REFERENCES status_lamaran(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lamaran_idlowongan_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_idlowongan_fkey FOREIGN KEY (idlowongan) REFERENCES lowongan(idlowongan) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lamaran_nip_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_nip_fkey FOREIGN KEY (nip) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lamaran_npm_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_npm_fkey FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_id_kat_log_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_id_kat_log_fkey FOREIGN KEY (id_kat_log) REFERENCES kategori_log(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_id_st_log_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_id_st_log_fkey FOREIGN KEY (id_st_log) REFERENCES status_log(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_idlamaran_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_idlamaran_fkey FOREIGN KEY (idlamaran, npm) REFERENCES lamaran(idlamaran, npm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lowongan_idkelasmk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_idkelasmk_fkey FOREIGN KEY (idkelasmk) REFERENCES kelas_mk(idkelasmk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lowongan_nipdosenpembuka_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_nipdosenpembuka_fkey FOREIGN KEY (nipdosenpembuka) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mata_kuliah_prasyarat_dari_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY mata_kuliah
    ADD CONSTRAINT mata_kuliah_prasyarat_dari_fkey FOREIGN KEY (prasyarat_dari) REFERENCES mata_kuliah(kode) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mhs_mengambil_kelas_mk_idkelasmk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY mhs_mengambil_kelas_mk
    ADD CONSTRAINT mhs_mengambil_kelas_mk_idkelasmk_fkey FOREIGN KEY (idkelasmk) REFERENCES kelas_mk(idkelasmk) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mhs_mengambil_kelas_mk_npm_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY mhs_mengambil_kelas_mk
    ADD CONSTRAINT mhs_mengambil_kelas_mk_npm_fkey FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: telepon_mahasiswa_npm_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: asa.fairuz
--

ALTER TABLE ONLY telepon_mahasiswa
    ADD CONSTRAINT telepon_mahasiswa_npm_fkey FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

