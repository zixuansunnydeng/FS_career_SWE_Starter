# Lecture 20

## Setup map elements

## 1. Launch the app on Android Emulator
- Because Chrome does not support mobile google map sdks

## 2. Add lat long to Restaurant Model
- Added helper to delete and create Restaurant model
- Rerun loadYelpToDB to load restaurant data

## 3. Change how restaurants are decoded
- Adding `lat`, `lng` to Restaurant model in dart
- Load these values when loading restaurant

## 4. Load Restaurants and create markers
- `Marker`: the annotations show on maps
- `Controller`: single instance that controls google map

## 5. Create mapResCard, and show the card whenever an annotation is tapped

# Task
1. Create a class named `ResMapCard` so that it looks better on map