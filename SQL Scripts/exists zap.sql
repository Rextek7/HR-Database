SELECT
    c.id,
    c.name
FROM
    candidate c
WHERE
    EXISTS (
        SELECT 1
        FROM offer o
        WHERE o.candidate_id = c.id
    );