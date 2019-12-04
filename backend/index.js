
const express = require('express');
const api = require('./src/api');
const app = express();
const port = process.env.BIRTHDAY_PORT || 3000;

app.use(express.json())
app.put('/hello/:account_name', api.save_birthday);
app.get('/hello', api.get_days_till_birthday);

app.listen(port, () => console.log(`app listening on port ${port}!`));

