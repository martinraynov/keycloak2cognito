# keycloak2cognito
Script for the migration of Keycloak users to AWS Cognito 

### Prerequisite

You must have `docker` & `docker-compose` installed on your machine to run the following commands

### Export the Realm from Keycloak

You must export the users from keycloak (see `make export_users`) and put the json files inside the `exports` folder.

### Import into Cognito User Pool

Run the following commands : 
```
make build
make migrate
```


For more information and option run `make help`
