from flask import Flask
from flask import jsonify
from flask import request
from flask_cors import CORS
import requests

from restaurant import Restaurant
from user import User

app = Flask(__name__)
CORS(app)


@app.route("/")
def hello_world():
    return "Hello, World"

@app.route("/getRes", methods=["GET"])
def getRes():
    output = []
    for res in Restaurant.scan():
        res_data = vars(res)['attribute_values']
        if 'priceRange' not in res_data:
            continue
        output.append(res_data)
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
            address=res['location']['address1']
        )
        resDB_data.save()

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

@app.route("/book", methods=["POST"])
def book():
    email = request.json["email"]
    resName = request.json["resName"]
    user = User.get(email)
    #res = Restaurant.get(resName)
    user.reservations.append(resName)
    user.save()
    return jsonify("Success")

def yelp_data():
    endpoint = "https://api.yelp.com/v3/businesses/search"
    params = {"term": "chinese", "location": "Toronto", "limit": 10}
    api_key = "hzaOAgO2PdMwrhhHpDkAV5OaI-OcSfxci56eLfJ_8NB9u-fVqu8TSRgod-J51yqIdXrfEIbqQGzBouc_y_z_71BHnLweMBEDGIiAUZ7UrXa4sZsk145FB0U0t-oAWXYx"
    header = {"Authorization": f"Bearer {api_key}"}
    r = requests.get(endpoint, headers=header, params=params)
    return r


