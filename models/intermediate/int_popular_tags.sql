WITH 
posts_questions_split_tags as 
(
  SELECT tag_id
  , tag
  , question_id
  , view_count
  FROM {{ref('int_posts_questions_split_tags')}}
)

SELECT tag_id
  , tag
  , COUNT(question_id) AS questions_count
  , SUM(view_count) AS total_views
FROM  posts_questions_split_tags
GROUP BY tag_id, tag
ORDER BY questions_count DESC