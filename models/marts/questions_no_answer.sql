WITH 
popular_tags as 
(
  SELECT tag_id
  , tag
  , questions_count
  FROM {{ref('int_popular_tags')}}
)

, posts_questions_split_tags as 
(
  SELECT question_id
  , tag_id
  , tag
  FROM {{ref('int_posts_questions_split_tags')}}
  WHERE answer_count = 0
)

SELECT p_tags.tag_id
  , p_tags.tag
  , p_tags.questions_count
  , COUNT(post_questions_split.question_id) AS questions_no_answer_count
FROM popular_tags AS p_tags
LEFT JOIN posts_questions_split_tags AS post_questions_split
  ON p_tags.tag_id = post_questions_split.tag_id
GROUP BY p_tags.tag_id, p_tags.tag, p_tags.questions_count
ORDER BY p_tags.questions_count DESC