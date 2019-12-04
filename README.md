
### Birthday service.

Allows to save bithday dates and tracks how many days left to the next birthday.

Install:

```
docker-compose build
docker-compose up -d
```

Run db tests:

```
docker exec -ti birthday_service_db_1 psql -U postgres -f test/test.sql
```

Run backend tests:

```
docker exec -ti birthday_service_backend_1 npm test
```
