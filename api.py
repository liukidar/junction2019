from PIL import Image, ImageDraw
import requests
import json
import time
import threading
import re
from flask import Flask

app = Flask(__name__)
db = {}


def monitoring_loop():
    fp = open("vare_1.jpg", "rb")
    im = Image.open(fp)
    draw = ImageDraw.Draw(im)
    width, height = im.size
    a4HeightInPx = height - 3508
    scalingFactor = 0.297 / a4HeightInPx

    while True:
        time.sleep(.100)

        response = requests.get('http://13.48.149.61:8000/notifycache.json')

        if response.status_code != 200:
            print('Error: impossible to reach endpoint')
            exit(0)

        data = "[" + response.text.rstrip(',\n') + "]"

        try:
            data = json.loads(data)
        except:
            data = []

        for part in data:
            for el in part['notifications']:
                row = {}

                row["x"] = ((float(el["locationCoordinate"]["x"]) / 3.281
                             ) / scalingFactor + 44) / 150
                row["y"] = ((float(el["locationCoordinate"]["y"]) / 3.281
                             ) / scalingFactor + 33) / 150

                if "1" in el["hierarchyDetails"]["floor"]["name"]:
                    row["floor"] = "1"
                elif "2" in el["hierarchyDetails"]["floor"]["name"]:
                    row["floor"] = "2"
                else:
                    row["floor"] = "3"

                row["last_update"] = time.time()

                if int(re.sub("[^0-9]", "", el["deviceId"])) % 3 == 0:
                    db[el["deviceId"]] = row

        now = time.time()

        db_copy = db.copy()
        for k, el in db_copy.items():
            if now - el["last_update"] > 20:
                db.pop(k)


@app.route("/")
def home():
    return json.dumps(db)


if __name__ == "__main__":
    monitoring_thread = threading.Thread(target=monitoring_loop)
    monitoring_thread.start()

    app.run(host='0.0.0.0')