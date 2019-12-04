
const birthday_registry = require('./birthday_registry');

async function save_birthday(req, res){
    try {
        await birthday_registry.save_birthday(req.params.account_name, req.body.dateOfBirth);
        return res.status(201).json();
    } catch (e){
        return res.status(500).json();
    }
}

async function get_days_till_birthday(req, res){
    try {
        var days = await birthday_registry.get_days_till_birthday(req.query.name);
        var message = '';
        if (days == null){
            return res.status(404).json();
        } else if (days == 0) {
            message = `Happy birthday, ${req.query.name}!`
        } else {
            message = `Hello, ${req.query.name}! Your birthday is in ${days} days`
        }
        return res.status(200).json({message: message});
    } catch (e){
        return res.status(500).json()
    }
}

module.exports = {
    save_birthday: save_birthday,
    get_days_till_birthday: get_days_till_birthday
}
