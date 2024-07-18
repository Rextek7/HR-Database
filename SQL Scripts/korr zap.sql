SELECT
    c.id,
    c.name,
    (SELECT COUNT(*) FROM offer o WHERE o.candidate_id = c.id) AS offer_count
FROM
    candidate c;

SELECT
    v.id,
    v.position,
    (SELECT COUNT(*) FROM offer o WHERE o.vacancy_id = v.id) AS offer_count
FROM
    vacancy v;