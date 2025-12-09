SELECT id as question_id
  , creation_date
  , tags
  , answer_count
FROM 
  {{source('stackoverflow', 'posts_questions')}} AS posts_questions
WHERE
  EXTRACT(YEAR FROM creation_date) = 2022;