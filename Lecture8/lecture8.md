# Lecture 8

## Table of Contents
1. CORS
2. Load Data From BE
3. AWS
4. Homework

## **1. Cross Origin Error Solution**
- `CORS` - **Cross Origin Resource Sharing**
  - Additional http header parameters to allow sites cross domain to share resources
  1. install `flask-cors`
  2. import `CORS`
  3. CORS(app)

## **2. Load yelp data from backend**
- We have a backend server now, if we still want to use Yelp data, we can just load from backend instead
- use `request` library to do http request in Python
- pass parameters instead of having it inside the url to make the code more manageable

## **3. Real Server**
- So far we have been using our laptop to server as a localhost server
- Let's try to use a real server

### **AWS**
- An on-demand cloud computing platform
    - `on-demand`: pay as your go
- Lots of distributed computing services
- Create an AWS account
    - You will need to add a billing info. But if you just follow what I am doing you won't get charged (maybe just a tiny bit <$1 later on)
- More next week!

## **4. Task for you**
1. Use Yelp API fetch 10 chinese restaurants in Toronto region
2. fetch `name`, `price`, `category => alias`, `category => title`, `rating`, `image_url`, then generate Restaurant object
3. Use `Image.network` to load image instead of using `Image.asset`
4. Use `fit` attribute in `Image.network` to stretch the image horizontally