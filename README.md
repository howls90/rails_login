# Rails login

Implementation login from scrath with welcome mail and reset password function by email.

Features:

* As a user, I can visit sign up page and sign up with my email (with valid format and unique in database) and password (with confirmation and at least eight characters).
* When I sign up successfully, I would see my profile page.
* When I sign up successfully, I would receive a welcome email.
* When I sign up incorrectly, I would see error message in sign up page.
* As a user, I can edit my username and password in profile page. I can also see my email in the page but I can not edit it.
* When I first time entering the page, my username would be my email prefixing, e.g. (email is “user@example.com” , username would be “user”)
* When I edit my username, it should contain at least five characters. (Default username does not has this limitation)
* As a user, I can log out the system.
* When I log out, I would see the login page.
* As a user, I can visit login page and login with my email and password.
* As a user, I can visit login page and click “forgot password” if I forgot my password.
* When I visit forgot password page, I can fill my email and ask the system to send reset password email.
* As a user, I can visit reset password page from the link inside reset password email and reset my password (with confirmation and at least eight characters).
* The link should be unique and only valid within six hours.

## Installation

### Local
Edit config/database.yml with the postgres credentials and run the following commands:
```
$ rails db:create
$ rails db:migrate
$ rails s
```

### Docker
By default I attached a docker-compose with the configuration of the project (app + postgres). But letter opener gem doesn't work with docker so to test the email functionalities use local installation or build just the db in the docker-compose:
```
$ docker-compose up db
$ rails db:create
$ rails db:migrate
$ rails s
```

## Testing
To test the application build the application in local or docker enviorment and then type the following commands:
```
$ rspec

``` 