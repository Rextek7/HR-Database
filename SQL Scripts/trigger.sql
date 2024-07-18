CREATE OR REPLACE FUNCTION update_vacancy_status_trigger()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.accept THEN
        UPDATE vacancy SET status = 'Closed' WHERE id = NEW.vacancy_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER offer_insert_trigger
    AFTER INSERT ON offer
    FOR EACH ROW
EXECUTE FUNCTION update_vacancy_status_trigger();