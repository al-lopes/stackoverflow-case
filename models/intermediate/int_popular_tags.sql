WITH 
posts_questions_split_tags as 
(
  SELECT tag_id
  , tag
  , question_id
  , view_count
  FROM {{ref('int_questions_split_tags_counts')}}
)

SELECT tag_id
  , tag
  , COUNT(question_id) AS total_questions
  , SUM(view_count) AS total_views
FROM  posts_questions_split_tags
GROUP BY tag_id, tag
ORDER BY total_questions DESC