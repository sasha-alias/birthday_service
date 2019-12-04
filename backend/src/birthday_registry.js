
const { Client } = require('pg')
//const connstr = process.env.PG_CONNSTR || "postgres://postgres@localhost:6432/postgres"

async function exec_query(query, params){
    const client = new Client();

    await client.connect();
    try {
        res =  await client.query(query, params);
        await client.end();
        return res
    } catch (e) {
        client.end();
        throw(e);
    }
}


async function save_birthday(account_name, birthday_date){
    await exec_query('SELECT birthday_interfaces.save_birthday($1::text, $2::date)', [account_name, birthday_date]);
}

async function get_birthday(account_name){
    ret = await exec_query('SELECT o_birthday_date as birthday_date FROM birthday_interfaces.get_birthday($1::text)', [account_name]);
    return ret.rows[0].birthday_date;
}

async function get_days_till_birthday(account_name){
    ret = await exec_query('SELECT o_days as days FROM birthday_interfaces.get_days_till_birthday($1::text)', [account_name]);
    return ret.rows[0].days;
}

module.exports = {
    save_birthday:  save_birthday,
    get_birthday: get_birthday,
    get_days_till_birthday: get_days_till_birthday
}
