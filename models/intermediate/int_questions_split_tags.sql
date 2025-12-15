WITH 
posts_questions_2022 as 
(
  SELECT question_id
    , tags
  FROM {{ref('stg_posts_questions')}}
)
, tags as 
(
  SELECT tag_id
    , tag
  FROM {{ref('stg_tags')}}
)

, split_tags as
(
  SELECT question_id
        , split_tags as tag
  FROM (
    SELECT SPLIT(tags,'|') AS tag
      , question_id
    FROM posts_questions_2022
      )
  CROSS JOIN UNNEST(tag) split_tags
)

SELECT {{ dbt_utils.generate_surrogate_key(['s_tags.question_id', 'tags.tag_id']) }} as question_tag_id
  , s_tags.question_id
  , tags.tag_id
FROM split_tags as s_tags
LEFT JOIN tags
ON s_tags.tag = tags.tag