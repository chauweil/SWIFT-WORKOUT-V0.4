from flask import Flask, jsonify, abort, request, make_response, url_for, render_template, send_file,Response
from PIL import Image
import base64
import pickle
import datetime
import logging
from logging.handlers import RotatingFileHandler
from io import BytesIO

import json


# -------- module app
app = Flask(__name__)


# -------- db load
db={ 'serie1': 23,'serie2': 22 ,'serie3': 23 ,'serie4': 18 ,'serie5': 23,'id':14 }
im = Image.open("./static/images/BIG1.jpg")
#im2 = Image.open("./static/images/download.jpeg")

#encoded_string =  base64.b64encode(open("./static/images/im2.jpeg", "rb").read())

# -------- db load

@app.route('/')
def home():
      return "welcome"

@app.route('/image')
def get_im2():
        return send_file("./static/images/download.jpeg", mimetype='image/jpeg')


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

# in command line
#curl -H "Content-Type: application/json" -X POST -d '{"urname":"xyz","password":"xyz"}' http://localhost:5000/q
@app.route('/q',methods=["POST"])
def get_image():
    content = request.files
    app.logger.info(type(content["fileset"]))
    content["fileset"].save(open('im.p',"wb"))
    # app.logger.info(content["file.jpg"])
    now = str(datetime.datetime.now())
    f = content["fileset"].read()
    pickle.dump(f,open( "f.jpeg", "wb" ))
    app.logger.info(content["fileset"])

    in_memory_file = io.BytesIO()
    f.save(in_memory_file)
    image = Image.open(io.BytesIO(image_data))
    im = Image.open(BytesIO(in_memory_file))
    app.logger.info(im)
    pickle.dump(content["fileset"],open( "image.jpeg", "wb" ))
    return "OK",200

@app.route('/r', methods=["POST"])
def get_q():
    content = request.json
    print(content['username'])
    pickle.dump(content['username'], open( now+"username.p", "wb"))
    return "OK",200


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
