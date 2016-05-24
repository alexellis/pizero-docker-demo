from flask import Flask, request

import time
from lights import *
import json

state = {"hits": 0}
lights1 = Lights()
app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    state["hits"] = state["hits"]+1
    lights1.show()
    time.sleep(0.01)
    lights1.hide()
    return json.dumps({"count": state["hits"] })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
