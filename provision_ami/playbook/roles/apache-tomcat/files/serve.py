#!/usr/bin/env python

from flask import Flask  
from flask import render_template

app = Flask(__name__)

@app.route("/")
def hello():  
    message = "Hello, World"
    return render_template('index.html', message=message)

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=int("8080"),debug=True)
