SELECT
    p.project_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    project p
        LEFT JOIN (
        SELECT *
        FROM vacancy
        WHERE status = 'Open'
    ) v ON p.id = v.project_id
GROUP BY
    p.project_name
ORDER BY
    vacancy_count DESC;

SELECT
    c.customer_name,
    v.position,
    AVG(v.salary) AS avg_salary
FROM
    customer c
        LEFT JOIN (
        SELECT *
        FROM vacancy
        WHERE status = 'Open'
    ) v ON c.id = v.customer_id
GROUP BY
    c.customer_name, v.position
ORDER BY
    avg_salary DESC;