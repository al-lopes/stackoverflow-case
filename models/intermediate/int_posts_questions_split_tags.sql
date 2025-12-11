WITH 
posts_questions_2022 as 
(
  SELECT *
  FROM {{ref('stg_posts_questions')}}
)
, tags as 
(
  SELECT *
  FROM {{ref('stg_tags')}}
)

, split_tags as
(
  SELECT question_id
        , creation_date
        , split_tags as tag
        , answer_count
        , view_count
  FROM (
    SELECT SPLIT(tags,'|') AS tag
      , question_id
      , creation_date
      , answer_count
      , view_count
    FROM posts_questions_2022
      )
  CROSS JOIN UNNEST(tag) split_tags
)

SELECT s_tags.question_id
  , s_tags.creation_date
  , tags.tag_id
  , s_tags.tag
  , s_tags.answer_count
  , s_tags.view_count
FROM split_tags as s_tags
LEFT JOIN tags
ON s_tags.tag = tags.tag