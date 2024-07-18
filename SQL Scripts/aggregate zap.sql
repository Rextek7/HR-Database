SELECT
    p.project_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    project p
        JOIN vacancy v ON p.id = v.project_id
        JOIN customer c ON v.customer_id = c.id
GROUP BY
    p.project_name;

SELECT
    l.location,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    location l
        JOIN vacancy v ON l.id = v.location_id
        JOIN customer c ON v.customer_id = c.id
GROUP BY
    l.location;

SELECT
    r.role_name,
    COUNT(v.id) AS vacancy_count,
    AVG(v.salary) AS avg_salary
FROM
    role r
        JOIN vacancy v ON r.id = v.role_id
        JOIN project p ON v.project_id = p.id
GROUP BY
    r.role_name;