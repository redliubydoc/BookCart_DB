create table schema_bkcrt_ms_shopping.tlanguage(

  lng_cd  varchar2(2)   not null,
  lng_nm  varchar2(100) not null,

  constraint pk_tlanguage primary key(
    lng_cd
  )
);

create table schema_bkcrt_ms_shopping.tgenre(

  gen_cd number(3)      not null,
  gen_nm varchar2(100)  not null,

  constraint pk_tgenre primary key(
    gen_cd
  )
);

create table schema_bkcrt_ms_shopping.tbook(

	isbn            varchar2(13)   not null,
	title           varchar2(100)  not null,
	author          varchar2(50)   not null,
  edition         number         not null,
	lng_cd          varchar2(2)    not null,
	description     varchar2(1000) not null,
  date_of_release date           not null,
	price           number         not null,
	resource_dir    varchar2(500)  not null,

  constraint pk_isbn primary key(
    isbn
  ),
  
  constraint fk_lng_cd foreign key(
    lng_cd
  ) references schema_bkcrt_ms_shopping.tlanguage(
    lng_cd
  )
);


create table schema_bkcrt_ms_shopping.tbook_genre(

  isbn  varchar2(13)    not null,
  gen_cd number(3)      not null,

  constraint pk_tbook_genre primary key(
    isbn,
    gen_cd
  ),

  constraint fk_isbn foreign key(
    isbn
  ) references schema_bkcrt_ms_shopping.tbook(
    isbn
  ),

  constraint fk_gen_cd foreign key(
    gen_cd
  ) references schema_bkcrt_ms_shopping.tgenre(
    gen_cd
  )
);
