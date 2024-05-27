## Cross Site Scripting

* Step 1: Open terminal and switch to project directory

```bash
cd /root/angular-xss/xss
```

* Step 2: Build the docker images for both frontend and the API

```bash
docker-compose build
```

* Step 3: Start the app

```bash
docker-compose up -d
```

* Step 4: Access the app on `http://<your-server-ip>:4200`

> **Note:** To fetch server ip type in `serverip` in the terminal

* Step 5: Signup as an admin, Enter some random email id and password, also enable the `Signup as an admin` checkbox

* Step 6: Now it's time to login as an Admin, While logging in as an Admin enable `Signin as an admin` flag

* Step 7: After successful login you should see `Add New Movies` option in the Navigation bar

* Step 8: Now create some movies using that option

* Step 9: While creating a new movies entry in the `Movie Link` input you can add an XSS payload like `javascript:alert("Hacked!")` 

* Step 10: If you are successful in creating the movie now access the `Movies` tab

* Step 11: Now click on the `Click Here` button to see an attack taking place, This should pop up with an alert box stating that it is `Hacked!`

* Step 12: You can repeat from `Step 9` this time you try with a different payload like `javascript:alert(window.localStorage.getItem('token'))`

* Step 13: If you are successful in the attack then you should see an alert box with a JWT token value.

### Teardown

* Step 1: Switch to project directory

```bash
cd /root/angular-xss/xss
```

* Step 2: Bring down the app

```bash
docker-compose down
```