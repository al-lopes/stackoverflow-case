WITH 
popular_tags as 
(
  SELECT tag_id
  , tag
  , questions_count
  , total_views
  FROM {{ref('int_popular_tags')}}
)

, posts_questions_split_tags as 
(
  SELECT tag_id
  , tag
  , question_id
  FROM {{ref('int_posts_questions_split_tags')}}
  WHERE answer_count = 0
)

, aux_ranking_tags as 
(
SELECT p_tags.tag_id
  , p_tags.tag
  , p_tags.questions_count
  , p_tags.total_views
  , COUNT(post_questions_split.question_id) AS questions_no_answer_count
FROM popular_tags AS p_tags
LEFT JOIN posts_questions_split_tags AS post_questions_split
  ON p_tags.tag_id = post_questions_split.tag_id
GROUP BY p_tags.tag_id, p_tags.tag, p_tags.questions_count, p_tags.total_views
ORDER BY p_tags.questions_count DESC
)

, ranking_tags as 
(
SELECT tag_id
  , tag
  , questions_count
  , rank() over (order by questions_count desc) as rnk_questions_count
  , total_views
  , rank() over (order by total_views desc) as rnk_total_views
  , questions_no_answer_count
FROM aux_ranking_tags
)

SELECT *
  , ROUND(questions_no_answer_count/questions_count, 2) AS pct_questions_no_answer
  , row_number() over(ORDER BY 0.7*rnk_questions_count + 0.3*rnk_total_views) AS final_rank
FROM ranking_tags
ORDER BY final_rank
