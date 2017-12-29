from flask import Flask, jsonify, abort, request, make_response, url_for, render_template, send_file,Response
from PIL import Image
import base64


import json


# -------- module app
app = Flask(__name__)


# -------- db load
db={ 'serie1': 23,'serie2': 22 ,'serie3': 23 ,'serie4': 18 ,'serie5': 23,'id':14 }
im = Image.open("./static/images/BIG1.jpg")
encoded_string =  base64.b64encode(open("./static/images/BIG1.jpg", "rb").read())

# -------- db load

@app.route('/')
def home():
      return "welcome"


@app.route('/im')
def get_im():
        js = json.dumps(encoded_string.decode('utf-8'))
        resp = Response(js, status=200, mimetype='application/json')
        return resp

@app.route('/name')
def get_name():
        js = json.dumps(db)
        resp = Response(js, status=200, mimetype='application/json')
        return resp


@app.route('/q')
def get_q():
    content = request.json
    print(content)
    return "OK",200


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
