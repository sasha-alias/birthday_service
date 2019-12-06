
# Birthday service.

Allows to save bithday dates and tracks how many days left to the next birthday.

## Run service locally using docker-compose.


Install:

```
docker-compose build
docker-compose up -d
```

The web service is available at http://localhost:3000/
The database is available at postgres://postgres@localhost:5432

Run db tests:

```
docker exec -ti birthday_service_db_1 psql -U postgres -f test/test.sql
```

Run backend tests:

```
docker exec -ti birthday_service_backend_1 npm test
```

## Deploy to a development environment using Vagrant.

Prerequisites: vagrant, ansible

Create development environment:

```
mkdir ssh
ssh-keygen -f ssh/id_rsa -N ''
vagrant up
```

Install postgresql cluster:

```
ansible-playbook -i infra/dev/inventory.yaml playbooks/install_db.yaml
```
