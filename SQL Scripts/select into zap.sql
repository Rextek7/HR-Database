SELECT
    c.name,
    c.birth_date,
    c.phone,
    c.mail
INTO
    candidate_export
FROM
    candidate c;