import json

f = open("data/data-paths.json", "r")
paths_dict = json.load(f)

import urllib.request
for key in paths_dict.keys():
    paths = paths_dict[key]
    urllib.request.urlretrieve(paths['remote'], paths['local'])
