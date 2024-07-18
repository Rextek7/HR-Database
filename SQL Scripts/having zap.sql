SELECT
    p.project_name,
    COUNT(v.id) AS vacancy_count
FROM
    project p
        JOIN vacancy v ON p.id = v.project_id
GROUP BY
    p.project_name
HAVING
    COUNT(v.id) > 5;