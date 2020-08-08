# Lecture 15

## Let's add another new feature
We want to allow this app to make a booking for a restaurant
So what do we need?
1. Need a way to make the booking
2. It should store the info that there's a booking
   1. **That means we need to store user data**
3. A way to see your bookings
4. Maybe change or cancel it

## 1. Add User Model
```dart
from pynamodb.models import Model
from pynamodb.attributes import UnicodeAttribute
from pynamodb.attributes import NumberAttribute
from pynamodb.attributes import ListAttribute

class User(Model): # inheritance
    class Meta:
        table_name = "User"
        region = 'us-east-1'
    
    email = UnicodeAttribute(hash_key=True)
    name = UnicodeAttribute()
    password = UnicodeAttribute()
    phoneNumber = UnicodeAttribute()

    reservations = ListAttribute() # List of resName
```

- HTTP POST: another type of http request, should modifies the server database

```dart
@app.route("/login", methods=["GET"])
def login():
    email = request.json["email"]
    password = request.json["password"]
    try:
        user = User.get(email)
    except:
        return jsonify("Incorrect email")
    if user.password == password:
        return jsonify("Success")
    else:
        return jsonify("Wrong Password")
```

## 2. Adding a fake user to DB

## 3. Update the UI to allow user to log in
- Adding `bottom_navigation_view.dart`
- Adding `bookings_view.dart`

## 4. Pass user data to details view


## Task
1. Create an api for reservation
```dart
@app.route("/book", methods=["POST"])
def book():
```
2. Update book the table button, so that it alerts successful when the reservation goes through