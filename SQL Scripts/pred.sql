CREATE OR REPLACE VIEW vacancy_info AS
SELECT
    v.id,
    v.position,
    p.project_name,
    c.customer_name,
    v.start_date,
    v.finish_date,
    v.status
FROM
    vacancy v
        JOIN project p ON v.project_id = p.id
        JOIN customer c ON v.customer_id = c.id;

CREATE OR REPLACE VIEW candidate_check_status AS
SELECT
    c.id,
    c.name,
    t.status AS talentq_status,
    s.status AS security_status
FROM
    candidate c
        LEFT JOIN talentq_check t ON c.id = t.candidate_id
        LEFT JOIN security_check s ON c.id = s.candidate_id;

