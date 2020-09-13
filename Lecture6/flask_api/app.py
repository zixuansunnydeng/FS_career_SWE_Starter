from flask import Flask
from flask import jsonify
from flask import request
from flask_cors import CORS
import requests

from restaurant import Restaurant
from user import User
import json
import redis

app = Flask(__name__)
CORS(app)
r = redis.Redis(host='localhost', port=6379, db=0)

@app.route("/")
def hello_world():
    print(r.get('key1').decode("utf-8"))
    return "Hello, World"


@app.route("/getRes", methods=["GET"])
def getRes():
    output = []
    keys = r.keys()
    # If exist data in redis
    if len(keys) > 0:
        for k in keys:
            output.append(json.loads(r.get(k)))
        return jsonify(output)
    # Otherwise, read from database, and add value to redis
    print("LOAD FROM DATABASE")
    for res in Restaurant.scan():
        res_data = vars(res)['attribute_values']
        if 'priceRange' not in res_data:
            continue
        output.append(res_data)
        r.set(res_data['resName'], json.dumps(res_data), ex=15)
    return jsonify(output)


@app.route("/loadYelpToDB", methods=["GET"])
def loadYelpToDB():
    output = yelp_data().json()['businesses']
    for res in output:
        if 'price' not in res:
            continue
        resDB_data = Restaurant(
            resName=res['name'],
            city=res['location']['city'],
            category1=res['categories'][0]['alias'],
            category2=res['categories'][0]['title'],
            rating=res['rating'],
            image_url=res['image_url'],
            priceRange=res['price'],
            address=res['location']['address1'],
            lat=res['coordinates']['latitude'],
            lng=res['coordinates']['longitude'],
        )
        resDB_data.save()
    return jsonify("SUCCESS")


@app.route("/login", methods=["POST"])
def login():
    email = request.json["email"]
    password = request.json["password"]
    try:
        user = User.get(email)
    except:
        return jsonify({"status": "Incorrect email"})
    if user.password == password:
        # loop over user's reservations, then fetch restaurant data
        res_images = []
        for resName in user.reservations:
            restaurant = Restaurant.get(resName)
            res_images.append(restaurant.image_url)
        return jsonify({"status": "Success", "user": vars(user)["attribute_values"], "resImages": res_images})
    else:
        return jsonify({"status":"Wrong Password"})


@app.route("/cancel_booking", methods=["POST"])
def cancel_booking():
    email = request.json["email"]
    resName = request.json["resName"]
    user = User.get(email)
    user.reservations.remove(resName)
    user.save()
    return jsonify("Success")

@app.route("/book", methods=["POST"])
def book():
    email = request.json["email"]
    resName = request.json["resName"]
    user = User.get(email)
    user.reservations.append(resName)
    user.save()
    return jsonify("Success")

@app.route("/getResByCategory", methods=["POST"])
def getResByCat():
    category = request.json["category"]
    output = []
    for res in Restaurant.scan():
        if res.category1 is None or res.category2 is None:
            continue
        if category in res.category1 or category in res.category2:
            res_data = vars(res)["attribute_values"]
            output.append(res_data)
    return jsonify(output)

@app.route("/delete", methods=["GET"])
def delete_all_res():
    Restaurant.delete_table()
    Restaurant.create_table(read_capacity_units=1, write_capacity_units=1)

@app.route("/getSearchResult", methods=["POST"])
def getSearchResult():
    search_input = request.json["input"]
    output = set()
    for res in Restaurant.scan():
        if search_input in res.category1:
            output.add(res.category1)
        if search_input in res.category2:
            output.add(res.category2)
    return jsonify(list(output))

def yelp_data():
    endpoint = "https://api.yelp.com/v3/businesses/search"
    params = {"term": "Dessert", "location": "Canada", "limit": 20}
    api_key = ""
    header = {"Authorization": f"Bearer {api_key}"}
    r = requests.get(endpoint, headers=header, params=params)
    return r


