SELECT
    id,
    position,
    salary,
    salary * 1.1 AS increased_salary
FROM
    vacancy
WHERE
    status = 'Open';

SELECT
    id,
    position,
    salary * 0.87 AS salary_after_tax
FROM
    vacancy
WHERE
    status = 'Open' AND salary > 50000;