create or replace package pk_feedback_mgnt 
is
  procedure pr_insert_feedback(
    p_isbn          in  tfeedback.isbn%type,
    p_user_id       in  tfeedback.user_id%type,
    p_username      in  tfeedback.username%type,
    p_rating        in  tfeedback.rating%type,
    p_review        in  tfeedback.review%type,
    p_feedback      out sys_refcursor,
    p_log           out varchar2
  );

  procedure pr_update_feedback(
    p_feedback_id   in  tfeedback.feedback_id%type,
    p_rating        in  tfeedback.rating%type,
    p_review        in  tfeedback.review%type,
    p_feedback      out sys_refcursor,
    p_log           out varchar2
  );
end pk_feedback_mgnt;