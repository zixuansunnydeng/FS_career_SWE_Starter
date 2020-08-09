# Lecture 16

1. **Need a way to make the booking**
2. It should store the info that there's a booking
   1. That means we need to store user data
3. **A way to see your bookings**
4. Maybe change or cancel

## Continue
1. Add booking functionality to button
2. Show bookings history on UI
   1. Means we need a user class on frontend as well

## 1 Add booking functionality to button, and booking api
```python
@app.route("/book", methods=["POST"])
def book():
    email = request.json["email"]
    resName = request.json["resName"]
    user = User.get(email)
    res = Restaurant.get(resName)
    user.reservations.append(resName)
    user.save()
    return jsonify("Success")
```

## 2. Show bookings history on UI
- If using callback function again, it becomes very tedious to pass the function around the children
- New solution: `provider`
  - https://pub.dev/packages/provider
- It provides a convenient way to manage state around parent and children views

## 3. Prevent a restaurant getting rebooked
- disable the button if already booked

## 4. Load previous bookings info from the database
- change backend so that it returns the reservations


## Task
1. Change the type of provider to `User`, so that
   1. Create a `User` class
```dart
class User {
   String useremail;
   String name;
   List<String> reservations;
}
```
   2. Change backend to return all user info
```python
{"status": "Success", "user": vars(user)["attribute_values"]}
```
   3. In `main.dart`, change provider to be 
```dart
Provider.of<User>(
   create: (_) => null,
   child: ...
)
```
   4. inside `bookings_view`, it should create the user whenever log in is successful
   5. inside `home_view`, update headline to `Good Morning {user_name}`
      1. If user is null, use a placeholder
   6. Get rid of `useremail` variable in views and now you can use `Provider.of<User>(context, listen:false).useremail` for every useremail check