select
  paginated_table_b.*
from
  (
    select
      paginated_table_a.*,
      rownum row_no,
      count(*) over() item_count
    from
      (
        select
          *
        from
          (
            select
              *
            from
              (
                select
                  b.*,
                  c.*,
                  count(*) over() review_count
                from
                  (
                    select
                      a.*,
                      round((avg(rating) over()), 1) average_rating,
                      count(*) over() feedback_count
                    from
                      (
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
                          isbn = '9780316187183'
                        order by
                          date_of_feedback desc
                      ) a
                  ) b,
                  (
                    select * from (select rating from tfeedback where isbn = '9780316187183')
                    pivot (count(rating) star_count for rating in (1, 2, 3, 4, 5))
                  ) c
                where
                  b.review is not null
              )
            where
              rating = 3
          )
          order by
            date_of_feedback desc
        ) paginated_table_a
  ) paginated_table_b
where
  paginated_table_b.row_no > 510 and
  paginated_table_b.row_no <= 520;