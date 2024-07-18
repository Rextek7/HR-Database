CREATE OR REPLACE FUNCTION get_candidates_with_test_results()
    RETURNS TABLE (
                      candidate_id INTEGER,
                      name VARCHAR(45),
                      verbal_test INTEGER,
                      numeric_test INTEGER,
                      prof_test INTEGER
                  )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT c.id, c.name, t.verbal_test, t.numeric_test, t.prof_test
        FROM candidate c
                 LEFT JOIN talentq_check t ON c.id = t.candidate_id;
END;
$$;

CREATE OR REPLACE FUNCTION get_vacancy_count_by_project(p_project_id INTEGER)
    RETURNS INTEGER
    LANGUAGE plpgsql
AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM vacancy
    WHERE project_id = p_project_id;

    RETURN v_count;
END;
$$;