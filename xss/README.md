# Setup Docker

## Preqrequisites

You must have docker on your local system<br/><br/>

-   In terminal go to the root of this repository<br/><br/>
-   Type the following command into the terminal `docker build ./api -t api`<br/><br/>
-   Type the following command into the terminal `docker build ./frontend -t frontend`<br/><br/>
-   To start the dockerized application enter the following command into the terminal `docker-compose up`
    <br/><br/>

-   The frontend application will be hosted on `http://localhost:4200/` and the backend will be hosted on `http://localhost:8000/`

# Run the application on your local system

## Prerequisites

You must have node and mongodb installed.<br/><br/>

-   In terminal go to the root of this repository<br/><br/>

-   In the terminal run the following commands

```
cd api
npm i
node app.js
```

-   At the root level in the terminal run the following commands

```
cd frontend
npm i
ng serve
```

-   The application will be hosted on `http://localhost:4200/` and the backend will be hosted on `http://localhost:8000`

# API Requests

-   To login

```
POST http://localhost:8000/signin

{
    "email": String,
    "password": String,
    "isAdmin": Boolean
}
```

-   To Signup

```
POST http://localhost:8000/signup

{
    "email": String,
    "password": String,
    "name": String,
    "isAdmin": Boolean
}
```

-   To get the list of movies

```
GET http://localhost:8000/movies
```

-   To add a new movie

```
POST http://localhost:8000/addmovie
{
    "name": String,
    "link": String
}
```

-   To get user info

```
POST http://localhost:8000/check

{
    "token": String
}
```

-   To update user info

```
POST http://localhost:8000/update
{
    "token": String,
    "name": String,
    "email": String
}
```

# Vulnerable payload

In the `Add Movies` section in the link section put `javascript:alert(window.localStorage('token'))`. Now in the `Movies` section, the link containing this movie will be vulnerable.
