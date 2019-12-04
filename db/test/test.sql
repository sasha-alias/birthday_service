

-- clear test data before tests run
DELETE FROM birthday_data.birthday_registry WHERE account_name = 'test_user';

-- test new user birthday
DO $$
BEGIN
    PERFORM birthday_interfaces.save_birthday('test_user', now()::DATE);
END;
$$;

-- test get birthday
DO $$
DECLARE
    _ret DATE;
BEGIN
    SELECT o_birthday_date
    FROM birthday_interfaces.get_birthday('test_user')
    INTO _ret;

    ASSERT _ret = now()::DATE, 'failed get birthday test';
END;
$$;


-- test update birthday
DO $$
DECLARE
    _ret DATE;
    _birhday DATE = (now() - INTERVAL '1 year')::DATE;
BEGIN
    PERFORM birthday_interfaces.save_birthday('test_user', _birhday);

    SELECT o_birthday_date
    FROM birthday_interfaces.get_birthday('test_user')
    INTO _ret;

    ASSERT _ret = _birhday, 'failed update birthday test';
END;
$$;

-- test get birthday of non existing user
DO $$
DECLARE
    _ret DATE;
BEGIN
    DELETE FROM birthday_data.birthday_registry
    WHERE account_name = 'test_user';

    SELECT o_birthday_date
    FROM birthday_interfaces.get_birthday('test_user')
    INTO _ret;

    ASSERT _ret IS NULL, 'failed get non existing birthday test';
END;
$$;

-- test number of days till next birthday this year birthday
DO $$
DECLARE
    _birthday DATE = 'today'::DATE + INTERVAL '5 days' - INTERVAL '20 years';
    _days INT;
BEGIN
    PERFORM birthday_interfaces.save_birthday('test_user', _birthday);
    SELECT o_days FROM birthday_interfaces.get_days_till_birthday('test_user')
    INTO _days;

    ASSERT _days = 5, 'failed to diff next birthday this year';
END;
$$;

-- test number of days till next birthday next year birthday
DO $$
DECLARE
    _birthday DATE = 'yesterday'::DATE - INTERVAL '20 years';
    _days INT;
BEGIN
    PERFORM birthday_interfaces.save_birthday('test_user', _birthday);
    SELECT o_days FROM birthday_interfaces.get_days_till_birthday('test_user')
    INTO _days;

    ASSERT _days > 364, 'failed to diff next birthday next year';
END;
$$;
