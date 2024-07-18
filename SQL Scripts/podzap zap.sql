SELECT
    v.id,
    v.position,
    c.name AS candidate_name
FROM
    vacancy v
        JOIN (
        SELECT candidate_id, vacancy_id
        FROM offer
        WHERE accept = true
    ) o ON v.id = o.vacancy_id
        JOIN candidate c ON o.candidate_id = c.id;

SELECT
    c.name,
    o.comment
FROM
    candidate c
        JOIN (
        SELECT candidate_id, comment
        FROM offer
        WHERE accept = true
    ) o ON c.id = o.candidate_id;