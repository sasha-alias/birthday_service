
CREATE SCHEMA IF NOT EXISTS birthday_data;
CREATE SCHEMA IF NOT EXISTS birthday_interfaces;

--- birthday_registry

CREATE TABLE IF NOT EXISTS birthday_data.birthday_registry(account_name TEXT PRIMARY KEY, birthday_date DATE);

--- save_birthday

CREATE OR REPLACE FUNCTION birthday_interfaces.save_birthday(
    IN i_account_name TEXT,
    IN i_birhday_date DATE
) RETURNS void AS
$$
BEGIN
    INSERT INTO birthday_data.birthday_registry(account_name, birthday_date)
    VALUES (i_account_name, i_birhday_date)
    ON CONFLICT (account_name) DO UPDATE
    SET birthday_date = i_birhday_date;
END;
$$
LANGUAGE plpgsql SECURITY DEFINER;

--- get birthday
CREATE OR REPLACE FUNCTION birthday_interfaces.get_birthday(
    IN i_account_name TEXT,
    OUT o_birthday_date DATE
) RETURNS DATE AS
$$
BEGIN
    SELECT birthday_date
    FROM birthday_data.birthday_registry
    WHERE account_name = i_account_name
    INTO o_birthday_date;
END;
$$
LANGUAGE plpgsql SECURITY DEFINER;

--- get_days_till_birthday

CREATE OR REPLACE FUNCTION birthday_interfaces.get_days_till_birthday(
    IN i_account_name TEXT,
    OUT o_days INT
) RETURNS INT AS
$$
BEGIN
    SELECT
        CASE WHEN this_year_birthday >= 0
            THEN this_year_birthday
            ELSE next_year_birthday
        END AS days_till_birthday
    FROM (
        SELECT
        make_date(
            extract('year' FROM 'today'::date)::int,
            extract('month' FROM birthday_date)::int,
            extract('day' FROM birthday_date)::int
        ) - 'today'::date AS this_year_birthday,
        make_date(
            extract('year' FROM 'today'::date + interval '1 year')::int,
            extract('month' FROM birthday_date)::int,
            extract('day' FROM birthday_date)::int
        ) - 'today'::date AS next_year_birthday
        FROM birthday_data.birthday_registry
        WHERE account_name = i_account_name
    ) v
    INTO o_days;
END;
$$
LANGUAGE plpgsql SECURITY DEFINER;
