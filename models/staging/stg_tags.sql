SELECT tags.id as tag_id
  , tag_name as tag
FROM {{source('stackoverflow', 'tags')}} AS tags