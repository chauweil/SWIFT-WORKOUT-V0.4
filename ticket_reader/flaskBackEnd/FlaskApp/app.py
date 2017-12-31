from flask import Flask, jsonify, request,  send_file,Response
from PIL import Image
import pickle
from io import BytesIO
import numpy as np
from skimage import io
import json
from imageprocessing import ticket


# -------- module app
app = Flask(__name__)


# -------- db load
db={ 'serie1': 23,'serie2': 22 ,'serie3': 23 ,'serie4': 18 ,'serie5': 23,'id':14 }
a=ticket.ticketprocessing('./static/images/BIG2.jpg')
header= io.imread('./static/images/header_default.jpg',as_grey=True)
footer= io.imread('./static/images/footer_default.jpg',as_grey=True)

#encoded_string =  base64.b64encode(open("./static/images/im2.jpeg", "rb").read())

# -------- db load
@app.route('/upload',methods=["POST"])
def get_image2():

    #---------------------- saving the jpeg
    content = request.files
    f = content["fileset"]

    in_memory_file = BytesIO()
    f.save(in_memory_file)

    #image = Image.open(in_memory_file)
    #image.save('ticket.jpeg', 'JPEG')


    #----------------------  working scikit image
    app.logger.info("SCIKIT-IMAGE")

    image = io.imread(in_memory_file, as_grey=True)
    atemp = ticket.ticketprocessing(image)
    b = atemp.cropHF(header, footer)
    io.imsave('./static/images/temp.jpeg', b)
    #return send_file("./static/images/temp.jpeg", mimetype='image/jpeg')
    js = json.dumps(db)
    resp = Response(js, status=200, mimetype='application/json')
    return resp
    #encoded_string = base64.b64encode(open("./static/images/temp.jpg", "rb").read())
    #pickle.dump(content["fileset"],open( "image.jpeg", "wb" ))


@app.route('/')
def home():
      return "welcome"

@app.route('/image')
def get_im2():
        b = a.cropHF(header, footer)
        io.imsave('./static/images/temp.jpg', b)
        return send_file("./static/images/temp.jpg", mimetype='image/jpeg')


@app.route('/name')
def get_name():
        js = json.dumps(db)
        resp = Response(js, status=200, mimetype='application/json')
        return resp

# in command line
#curl -H "Content-Type: application/json" -X POST -d '{"urname":"xyz","password":"xyz"}' http://localhost:5000/q
@app.route('/q',methods=["POST"])
def get_image():

    #---------------------- saving the jpeg
    content = request.files
    app.logger.info(type(content["fileset"]))
    f = content["fileset"]
    #pickle.dump(f,open( "f.jpeg", "wb" ))

    #----------------------  conv
    in_memory_file = BytesIO()
    f.save(in_memory_file)
    app.logger.info(in_memory_file.getvalue())

    #----------------------  working scikit image
    app.logger.info("SCIKIT-IMAGE")


    image = io.imread(in_memory_file, as_grey=True)
    app.logger.info(type(image))

    #----------------------  working PIL
    app.logger.info("PIL")

    image = Image.open(in_memory_file)
    app.logger.info(image)
    image.save('ticket.jpeg', 'JPEG')

    # ----------------------  convert image to byte
    app.logger.info("BYTES")

    data2 = np.fromstring(in_memory_file.getvalue(), dtype=np.uint8)
    app.logger.info(bytearray(data2[:4]))

    #pickle.dump(content["fileset"],open( "image.jpeg", "wb" ))
    return "OK",200


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
