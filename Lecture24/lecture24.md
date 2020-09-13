# Lecture 24

# CS fundamentals
- `Runtime Complexity`: amount of time it takes an algorithm to run
  - Counts the number of elementary operations

<img src="./runtime.jpeg" height=300>

- **Hash table**
  - `Hash table` vs `Dictionary`
    - Dictionary is a more generic type
  - `Hash function`: a function that encodes a value into another value
  - Implementation: `array + hash function`
  - Lookup: Amortized `O(1)`
- **Set**
  - Addition: `O(log n)`
  - Lookup: Amortized `O(1)`
- Time complexity cheat sheet
  - https://www.bigocheatsheet.com/
- `OOP`
  - `Inheritance` vs. `Composition`
    - `Inheritance`: reuseable code
    - `Composition`: less dependency, allow better unit testing
  - `Abstract Class`: purpose not to be instantiated but to manage common properties or enforce common functionalities
  - `Encapsulation`: use of private function/class to achieve data hiding 
  - `static`: class-wide state and constants, not accessible to instances
    - `static` vs `class method`: static doesn't modify class state

# Frontend
- Flutter based hybrid mobile/web app
- Often refer as the `client`

### Flutter
- Based off `dart` programming language
  - `Dart`:
    - `dynamic` vs `final`
    - `dynamic`: change value and change type
    - `final`: run-time constant, variable can only be assigned once
      - compile-time vs run-time?
- `Material.dart`: Material Design library
- `Widget Tree`
  - `Widget`: UI component that defines what the UI looks like
```
MyApp
- MaterialApp (theme)
  - MyHomePage
    - Scaffold
      - AppBar
      - Center
        - Column
          - Text
          - Text (theme.of(context))
        - FloatingActionButton
          - Icon
  - Another page (theme.of(context))
```
- `Stateful Widget` vs `Stateless Widget`
  - Mutable states vs unmutable state
  - Mutate the state by using `useState()`
- `build`
  - Called when the widget is firstly built or when the widget is reloaded
  - `BuildContext`: contains context info regarding to a widget location
- Call an API
  - `async`: keyword to specify a function being asynchroonous
  - `await`: wait for an asynchronous function to finish
  - `whenComplete`: callback function, triggered when an async function is completed
- `Provider`: convenient way to manage global state within the application without needing to pass variable around


# Backend
- Often refer to as `the server side` 

### Json
- Type used for data exchange in the Internet
- `deserialization`: converting json type into a specific language type
- `serialization` converting data to json

### API
- `API`: set of rules allow programs to talk to each other
- `RESTFul API`: set of roles developers follow when creating API
  - Relying on http protocols
- `HTTP Methods`
  - `POST`, `GET`, `PUT`, `PATCH`, `DELETE`
- API endpoint structure
  - `http[s]://xxxx.com?/<param1>&<param2>`
- `status code`: indicates the state of a request response
  - `200`: success
  - `400`: bad request
  - `401`: unauthorized
  - `404`: not found
  - `500`: Internal server error
- `http header`: passing additional information in a request
  - e.g. what kind of data is passing along with

### Flask & Python
- `Python` is a `Dynamically typed` and `garbage-collected` language
- `Flask`: A micro web framework for creating python backend
  - `micro`: only basic functionalities are built-in like routing ,request handling, modulization, etc
- `Flask` vs `Django`:
  - `Django` has lots of functionalities by default, such as database ORM, admin page, Authorization, etc
  - `Flask` a lot easier to get started and gives flexbility for developers, but often needs installing extra libraries
- `Virtual Enviroment`: creates a development environment thats independent of your system's libraries
  - Why?
  - `python3 -m venv venv`
  - `source ./venv/bin/activate`
- Running flask
  - `export FLASK_APP=app.py`
  - `export FLASK_ENV=development`
  - `flask run`
 - Creating a flask endpoint
```
@app.route('xxx/')
def xxx():
    yyy
```

### CORS
- Chrome has `Same Origin Policy` to prevent cross site attack
  - Which manipulates cookies info and get user's information
- `CORS - Cross Origin Resource Sharing`: additional http header parameters to allow sites cross domain to share resources

# Server (AWS)
- Using AWS's on-demand cloud computing platform
- `EC2`: standard aws VM server
- Using `ssh` to enter EC2 server
  - `ssh`: Secured Shell, a network protocol that allows a secure way to control a remote computer
    - Windows needs to use Putty, or use VSCode
- Steps to enter Ec2 (Mac)
  - `chmod 400 *.pem` => `ssh -i *.pem ec2-user@ec2-<IP>.<region>.compute.amazonaws.com
- `Security Group`: manage security access for AWS services
  - Add `HTTP` type inbound, default to port 80

### Nginx
- Proxy server to redirect port 80 => port 5000

# Database

### Basics (relational database)
- `Database Schema`: organization of data
- `Tables`: defined by Schema, tables define column keys
  - `Column`: value with the same type
  - `Row`: structured data in a table
  - `Primary key`: uniquely identifies a column
- `MySQL` is the most common relational database, so often refer to as `SQL database`

### DynamoDB
- Distributed `NoSQL` database
  - `NoSQl`: non-relational database
- `SQL vs NoSQL`
  1. SQL is `table-based`, NoSQL is `document-based`
  2. SQL schema must be defined first and fixed, NoSQL schema can be modified
  3. SQL provides `ACID` properly to allow `transactions`, while only a few nosql database can achieve this
  4. SQL database uses SQL query language, NoSQL has no such a thing
  5. SQL has built-in indexing, NoSQL needs to declare (more on this later)
- Need aws credentials in order to run
  - managed by `IAM`, and pass the credentials to `~/.aws/credentials`

### ORM
- `ORM`: object-relational mapping
  - Able to write database commands using object-oriented programming
- `Pynamodb`: python ORM library for DynamoDB

## In-memory Cache
- `Cache`: a set of data that's accessed often
- `CPU cache`: small block of RAM that's physically part of the CPU, refer to as hardware cache
  - caches RAM access operations
- `In memory cache`: data that are temporarily stored in computer's main memory
- Why
  - Database stores value in hard drive
  - SSD random access: 10e-5 seconds
  - RAM: 10e-9 seconds
  - RAM is 1000 times faster
- `Redis`: common choice for in-memory cache in industry

## Containers
- `Containerization`: the process of bundling the entire application and it's dependencies in a package, so that it can then be run on any infrastructure
- `Container`: a lightweight package that contains application and its dependencies
- `Container image`: container at runtime
- `Docker`: most common containerization technology


# Tools

### VSCode

### Git/Github
- Version control
- Usual flow to commit changes
  1. `git status` to check your current status of the files
  2. `git checkou -b <BRANCH>`: create a new branch
  3. `git add`: add any modified/untracked file
     1. Often use `git add -A` to add all modified/untracked files at once.
  4. `git commit -m 'MESSAGE`: to commit your changes with a message
  5. `git push origin <BRANCH>`: push your branch to github repo
  6. Go to the repo and your will see a request for making a pull request
- Others
  - `git pull origin <BRANCH>`: get the most recent version of a branch
  - `git checkout <FILE>` to reset a file to state of the HEAD
