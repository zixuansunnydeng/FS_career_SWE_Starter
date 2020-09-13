from python:3.7-alpine

WORKDIR /code

ENV FLASK_APP app.py
ENV FLASK_ENV development
ENV FLASK_RUN_HOST 0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . .
CMD ["flask", "run"]

ENV AWS_ACCESS_KEY_ID=AKIAW5DQKJT7YFHQE74F
ENV AWS_SECRET_ACCESS_KEY=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