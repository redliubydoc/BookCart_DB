create table schema_bkcrt_ms_feedback.tfeedback (
  feedback_id      number             not null,
  isbn             varchar2(13)       not null,
  user_id          number             not null,
  username         varchar2(25)       not null,
  rating           number             not null,
  date_of_feedback date               not null,
  review           clob,      
  create_ts        timestamp(6)       not null,
  update_ts        timestamp(6),      constraint ck_rating_range check (rating >= 1 and rating <= 5),

  constraint pk_tfeedback primary key ( 
    feedback_id 
  ),

  constraint uq_isbn_user_id unique ( 
    isbn,
    user_id 
  )
)


create sequence schema_bkcrt_ms_feedback.sq_feedback_id
  minvalue 1 
  maxvalue 9999999999999999999999999999 
  increment by 1 
  start with 2001;
/


create or replace trigger schema_bkcrt_ms_feedback.tg_feedback_id before insert on tfeedback for each row
begin
  if :old.feedback_id = null
  then
    select
      sq_feedback_id.nextval
    into 
      :new.feedback_id
    from
      dual;
  end if;
end;
/


create or replace trigger schema_bkcrt_ms_feedback.tg_create_ts before insert on tfeedback for each row
begin
  select
    systimestamp
  into 
    :new.create_ts
  from
    dual;
end;
/


create or replace editionable trigger schema_bkcrt_ms_feedback.tg_update_ts before update on tfeedback for each row
begin

  select
    systimestamp
  into 
    :new.update_ts
  from
    dual;
end;
/
