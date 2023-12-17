create or replace package body pk_feedback_mgnt is

  procedure pr_insert_feedback(
    p_isbn          in  tfeedback.isbn%type,
    p_user_id       in  tfeedback.user_id%type,
    p_username      in  tfeedback.username%type,
    p_rating        in  tfeedback.rating%type,
    p_review        in  tfeedback.review%type,
    p_feedback      out sys_refcursor,
    p_log           out varchar2
  ) 
  is
    v_feedback_id constant number not null := sq_feedback_id.nextval;
  begin

    p_log := p_log || 'v_feedback_id: ' || v_feedback_id;
    p_log := p_log || ' :: p_isbn: ' || p_isbn;
    p_log := p_log || ' :: p_user_id: ' || p_user_id;
    p_log := p_log || ' :: p_username: ' || p_username;
    p_log := p_log || ' :: p_rating: ' || p_rating;
    p_log := p_log || ' :: p_review: ' || p_review;
    

    p_log := p_log || ' :: [..][insert into tfeedback(feedback_id, isbn, user_id, username, rating, date_of_feedback, review) values (''' || v_feedback_id || ''', ''' || p_isbn || ''', ''' || p_user_id || ''', ''' || p_username || ''', ''' || p_rating || ''', ''' || sysdate || ''', ''' ||  p_review || ''');]';
    
    insert into tfeedback(
      feedback_id, 
      isbn, 
      user_id, 
      username, 
      rating, 
      date_of_feedback, 
      review
    ) 
    values (
      v_feedback_id, 
      p_isbn, 
      p_user_id, 
      p_username, 
      p_rating, 
      sysdate, 
      p_review
    );

    p_log := p_log || ' :: [ok][insert into tfeedback(feedback_id, isbn, user_id, username, rating, date_of_feedback, review) values (''' || v_feedback_id || ''', ''' || p_isbn || ''', ''' || p_user_id || ''', ''' || p_username || ''', ''' || p_rating || ''', ''' || sysdate || ''', ''' ||  p_review || ''');]';
      
    p_log := p_log || ' :: [..][select feedback_id, isbn, user_id, username, rating, date_of_feedback, review from tfeedback where feedback_id = ''' || v_feedback_id || ''';]';

    open p_feedback for 
      select 
        feedback_id,
        isbn,
        user_id,
        username,
        rating,
        date_of_feedback,
        review
      from 
        tfeedback 
      where 
        feedback_id = v_feedback_id;

    p_log := p_log || ' :: [ok][select feedback_id, isbn, user_id, username, rating, date_of_feedback, review from tfeedback where feedback_id = ''' || v_feedback_id || ''';]';
  end;

  procedure pr_update_feedback(
    p_feedback_id   in  tfeedback.feedback_id%type,
    p_rating        in  tfeedback.rating%type,
    p_review        in  tfeedback.review%type,
    p_feedback      out sys_refcursor,
    p_log           out varchar2
  )
  is
  begin

    p_log := p_log || 'p_feedback_id: ' || p_feedback_id;
    p_log := p_log || ' :: p_rating: ' || p_rating;
    p_log := p_log || ' :: p_review: ' || p_review;

    p_log := p_log || ' :: [..][update tfeedback set rating = ''' || p_rating || ''', review = ''' || p_review || ''' where feedback_id = ''' || p_feedback_id || ''';]';
    
    update tfeedback 
    set 
      rating = p_rating,
      review = p_review
    where
      feedback_id = p_feedback_id;

    p_log := p_log || ' :: [ok][update tfeedback set rating = ''' || p_rating || ''', review = ''' || p_review || ''' where feedback_id = ''' || p_feedback_id || ''';]';

    p_log := p_log || ' :: [..][select feedback_id, isbn, user_id, username, rating, date_of_feedback, review from tfeedback where feedback_id = ''' || p_feedback_id || ''';]';
        
    open p_feedback for 
      select 
        feedback_id,
        isbn,
        user_id,
        username,
        rating,
        date_of_feedback,
        review
      from 
        tfeedback 
      where 
        feedback_id = p_feedback_id;

    p_log := p_log || ' :: [ok][select feedback_id, isbn, user_id, username, rating, date_of_feedback, review from tfeedback where feedback_id = ''' || p_feedback_id || ''';]';

  end;
end pk_feedback_mgnt;