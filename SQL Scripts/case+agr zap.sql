SELECT
    p.project_name,
    COUNT(CASE WHEN v.status = 'Open' THEN 1 END) AS open_vacancies,
    COUNT(CASE WHEN v.status = 'Closed' THEN 1 END) AS closed_vacancies
FROM
    project p
        LEFT JOIN vacancy v ON p.id = v.project_id
GROUP BY
    p.project_name;