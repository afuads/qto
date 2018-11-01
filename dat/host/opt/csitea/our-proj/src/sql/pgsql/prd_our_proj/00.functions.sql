CREATE FUNCTION "fnc_set_update_time" () RETURNS trigger AS '
    BEGIN
        NEW.update_time = DATE_TRUNC(''second'', NOW());
        RETURN NEW;
    END;'
LANGUAGE "plpgsql";

select exists(select * from pg_proc where proname = 'fnc_set_update_time');