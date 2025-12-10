WITH 
posts_questions_split_tags as 
(
  SELECT question_id
  , tag_id
  , tag
  FROM {{ref('int_posts_questions_split_tags')}}
)

SELECT tag_id
  , tag
  , COUNT(question_id) AS questions_count
FROM  posts_questions_split_tags
GROUP BY tag_id, tag
ORDER BY questions_count DESC