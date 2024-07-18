CREATE OR REPLACE PROCEDURE update_vacancy_status()
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE vacancy
    SET status = 'Closed'
    WHERE id IN (
        SELECT vacancy_id
        FROM offer
        WHERE accept = true
    );
END;
$$;

CREATE OR REPLACE PROCEDURE process_candidate(p_candidate_id INTEGER)
    LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM candidate WHERE id = p_candidate_id) THEN
        UPDATE candidate SET relocation_status = 'In Progress' WHERE id = p_candidate_id;
        INSERT INTO talentq_check (candidate_id, status) VALUES (p_candidate_id, 'Sent');
        INSERT INTO security_check (candidate_id, status) VALUES (p_candidate_id, 'Sent');
    ELSE
        RAISE EXCEPTION 'Candidate not found';
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE add_candidate(
    p_name VARCHAR(45),
    p_birth_date DATE,
    p_phone VARCHAR(400),
    p_mail VARCHAR(400)
)
    LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        INSERT INTO candidate (name, birth_date, phone, mail)
        VALUES (p_name, p_birth_date, p_phone, p_mail);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Error adding candidate: %', SQLERRM;
    END;
END;
$$;

CREATE OR REPLACE PROCEDURE add_vacancy_comment(
    p_vacancy_id INTEGER,
    p_user_name VARCHAR(45),
    p_comment VARCHAR(400)
)
    LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO comment (vac_id, user_name, comment, date)
    VALUES (p_vacancy_id, p_user_name, p_comment, CURRENT_DATE);
END;
$$;

CREATE OR REPLACE PROCEDURE update_security_check_status(
    p_candidate_id INTEGER,
    p_status VARCHAR(45)
)
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE security_check
    SET status = p_status,
        result_date = CASE WHEN p_status = 'Completed' THEN CURRENT_DATE ELSE NULL END
    WHERE candidate_id = p_candidate_id;
END;
$$;
