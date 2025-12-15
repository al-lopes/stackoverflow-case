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
  SELECT *
  FROM {{ref('int_questions_split_tags')}}
)

SELECT s_tags.question_tag_id
  , posts_questions_2022.question_id
  , tags.tag_id
  , tags.tag
  , posts_questions_2022.creation_date
  , posts_questions_2022.answer_count
  , posts_questions_2022.view_count
FROM split_tags as s_tags
LEFT JOIN tags
ON s_tags.tag_id = tags.tag_id
LEFT JOIN posts_questions_2022
ON posts_questions_2022.question_id = s_tags.question_id