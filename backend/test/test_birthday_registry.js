
const assert = require('assert');
const moment = require('moment');
const birthday_registry = require('../src/birthday_registry');

describe("Birthday registry:", function(){
    it("saves birthday", async function(){
        await birthday_registry.save_birthday('backend_test_user', '2019-12-12')
    });

    it("gets saved birthday", async function(){
        var birthday_date = await birthday_registry.get_birthday('backend_test_user')
        assert.equal(moment(birthday_date).format('YYYY-MM-DD'), '2019-12-12');
    });

    it("returns null when account name doesn't exist", async function(){
        var birthday_date = await birthday_registry.get_birthday('not_existing_username')
        assert.equal(birthday_date, null);
    });

    it("doesn't save malformed birthday", async function(){
        await assert.rejects( async function(){
            await birthday_registry.save_birthday('backend_test_user', 'blablabla');
        });
    });

    it("gets number of days till birthday", async function(){
        var days = await birthday_registry.get_days_till_birthday('backend_test_user');
        assert.ok(days >= 0);
    });

    it("number of days till birthday of not existing user returns null", async function(){
        var days = await birthday_registry.get_days_till_birthday('not_existing_username');
        assert.ok(days === null);
    });
});
