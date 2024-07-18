SELECT
    v.id,
    v.position,
    v.salary,
    LAG(v.salary) OVER (ORDER BY v.start_date) AS prev_salary
FROM
    vacancy v;