SELECT
    c.name AS candidate_name,
    o.comment AS offer_comment
FROM
    candidate c
        LEFT JOIN offer o ON c.id = o.candidate_id
WHERE
    o.comment IS NULL;