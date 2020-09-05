# Lecture 22

## Cache
- `Cache`: general keyword that means the sets of data that are accessed often
- `CPU cache`: Small block of RAM that is physically a part of the CPU, often referred as hardware cache
  - caches RAM access operations

## In-memory cache
- `Memory Cache`: Data that are temporarily stored in computer's main memory in order to speed up access
  - e.g. RAM or on a disk driver

## Why?
- database usually store data on disk/storage or SSDs
  - SSD random access: 10e-5 seconds
  - RAM: 10e-9 seconds
  - RAM is 1000 times faster!
- Drawback
  - memory is usually not persistent, meaning they get erased after the server reboots

## Redis
- https://redis.io/topics/introduction
- Remote Dictionary Server
- Very fast, open-source, in-memory key-value data store
- Can be used as database, cache, message brocker and message queue

## Our usecase
- We don't necessarily need to load restaurant data from the database every single time
- We could use in-memory cache to cache the result and then reuse them

## Install Redis 
- Follow this site to install Redis in AWS-linux
  - https://medium.com/@ss.shawnshi/how-to-install-redis-on-ec2-server-for-fast-in-memory-database-f30c3ef8c35e
- Install `redis-py`
  - https://pypi.org/project/redis/

## Using Redis in `app.py`

## Setting TTL
- `TTL`: Time To Live, means the amount of time a kv pair can live inside cache
- Why? Because without it we would not update the data
- `stale data`: the data that are no longer fresh
  