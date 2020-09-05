# Lecture 21

## Adding search functionality

## 1. Adding a new view

## 2. Adding new endpoint to backend
- An easy approach: loop through all restaurants and check if input is one of the categories
- How to dedup?
- Using `set`
- Time complexity of set
  - Add: `O(log n)`
    - Why?
  - Lookup: Amortized `O(1)`

## 3. Connect frontend to backend endpoint

## Task
1. Click listtile, do a category search and present ListView
- You should be using multiple existing components (`res_list_view.dart`)