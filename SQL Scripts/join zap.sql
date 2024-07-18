SELECT
    p.project_name,
    c.customer_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    project p
        JOIN vacancy v ON p.id = v.project_id
        JOIN customer c ON v.customer_id = c.id
        JOIN offer o ON v.id = o.vacancy_id
GROUP BY
    p.project_name,
    c.customer_name;