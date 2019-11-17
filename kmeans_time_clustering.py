from numpy import array
import requests
import json
from PIL import Image, ImageDraw
import time
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import math


def sigmoid(x):
    return 1 / (1 + math.exp(-x))


db = {}
records = {}

fp = open("vare_1.jpg", "rb")
im = Image.open(fp)
draw = ImageDraw.Draw(im)
width, height = im.size
a4HeightInPx = height - 3508
scalingFactor = 0.297 / a4HeightInPx

for _ in range(0, 5):

    for _ in range(0, 100):

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

                if row["floor"] == "1":
                    db[el["deviceId"]] = row

    features = []
    macs = []
    for k, el in db.items():
        features.append([el["x"], el["y"]])
        macs.append(k)

    features = array(features)

    results = []

    kmeans = KMeans(n_clusters=7, random_state=0).fit(features)  #elbow method
    classes = kmeans.labels_

    for a in range(0, len(macs)):
        for b in range(0, len(macs)):
            if macs[a] != macs[b]:
                if classes[a] == classes[b]:
                    bonus = 0.1
                else:
                    bonus = -0.1

                if macs[a] + macs[b] in records:
                    records[macs[a]
                            + macs[b]] = records[macs[a] + macs[b]] + bonus
                elif macs[b] + macs[a] in records:
                    records[macs[b]
                            + macs[a]] = records[macs[b] + macs[a]] + bonus
                else:
                    records[macs[a] + macs[b]] = 0

for k, v in sorted(records.items(), key=lambda item: item[1]):
    print(k, sigmoid(v))