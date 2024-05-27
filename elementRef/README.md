# Setup Docker

## Preqrequisites

You must have docker on your local system

- In terminal go to the root of this repository
- Type the following command into the terminal `docker build ./api -t api`
- Type the following command into the terminal `docker build ./frontend -t frontend`
- To start the dockerized application enter the following command into the terminal `docker-compose up`

- The frontend application will be hosted on `http://localhost:4200/` and the backend will be hosted on `http://localhost:8000/`

## Run the application on your local system

## Prerequisites

You must have node and mongodb installed.

- In terminal go to the root of this repository

- In the terminal run the following commands

``` bash
cd api
npm i
node app.js
```

- At the root level in the terminal run the following commands

``` bash
cd frontend
npm i
ng serve
```

- The application will be hosted on `http://localhost:4200/` and the backend will be hosted on `http://localhost:8000`

## API Requests

- To login

``` http
POST http://localhost:8000/signin

{
    "email": String,
    "password": String
}
```

- To Signup

``` http
POST http://localhost:8000/signup

{
    "email": String,
    "password": String,
    "name": String
}
```

- To find professionals

``` http
POST http://localhost:8000/find

{
    "token": String
}
```

- To update user info

``` https
POST http://localhost:8000/update
{
    "token": String,
    "name": String,
    "email": String,
    "profession": String,
    "url": String
}
```

## Vulnerable payload

In the `Update` section in the Url section put `javascript:alert(window.localStorage('token'))`. Now in the `Professionals` section, the link containing this user's website will be vulnerable.
