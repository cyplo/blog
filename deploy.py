#!/usr/bin/python3

import json
import os
import requests
import sys
import hashlib

if len(sys.argv) != 3 and len(sys.argv) != 4:
    print('usage: ')
    print(sys.argv[0] + " netlify_site_id directory_to_deploy [deployment_id_to_continue]")
    sys.exit(1)
auth_token = os.getenv("NETLIFY_TOKEN") 
if not auth_token:
    print('Please set NETLIFY_TOKEN')
    sys.exit(2)
site_id = sys.argv[1]
directory_to_deploy = os.path.abspath(sys.argv[2])

print("Deploying " + directory_to_deploy + " to Netlify as " + site_id)
directory_to_hash = directory_to_deploy
paths_to_hash = []

for root, dirs, filenames in os.walk(directory_to_hash, topdown=False):
    paths_to_hash += ((os.path.join(root, name)) for name in filenames)

print('Validating structure...', end="")
index_filename = "index.html"
if os.path.isfile(os.path.join(directory_to_hash, index_filename)):
    print('OK')
else:
    print('No '+index_filename)
    sys.exit(3)
    
print('Hashing...', end="")
file_hashes = {}
for path in paths_to_hash:
    BUF_SIZE = 65536  # lets read stuff in 64kb chunks!

    sha1 = hashlib.sha1()

    with open(path, 'rb') as f:
        while True:
            data = f.read(BUF_SIZE)
            if not data:
                break
            sha1.update(data)

        file_hash = sha1.hexdigest()
        relative_path=path.replace(directory_to_deploy, '')
        file_hashes[relative_path] = file_hash
print('OK')

json_headers = {"Authorization":"Bearer " + auth_token, 'content-type': "application/json"}
base_url = 'https://api.netlify.com/api/v1/'
site_url = base_url + "sites/" + site_id + "/"
deploys_url = site_url + "deploys/"
response = {}

if not len(sys.argv) == 4:
    print('Creating new deployment...', end="")

    new_deploy = {'files' : file_hashes, 'context': 'deploy-preview', 'draft': True}
    new_deploy_json = json.dumps(new_deploy)
    response = requests.post(url=deploys_url, headers=json_headers, data=new_deploy_json)

    if not response.ok:
        print('Failed with error')
        print(response.content)
        sys.exit(4)

    deployment_id = response.json()['id']
else:
    print('Getting deployment information...', end="")
    deployment_id = sys.argv[3]
    deploy_url = deploys_url + deployment_id + "/"
    response = requests.get(url=deploy_url, headers=json_headers)
    if not response.ok:
        print('Failed with error')
        print(response.content)
        sys.exit(5)

print(deployment_id)

required_file_hashes = response.json()['required']
files_for_hashes = {v: k for k, v in file_hashes.items()}

new_deploy_url = base_url + "deploys/" + deployment_id + "/"
file_upload_headers = {"Authorization":"Bearer " + auth_token, 'content-type': "application/octet-stream"}

for required_hash in required_file_hashes:
    current_file_name = files_for_hashes[required_hash]
    print('Uploading ' + current_file_name + "...", end="")
    with open(os.path.join(directory_to_deploy, "./"+current_file_name), 'rb') as current_file_handle:
        file_upload_url = new_deploy_url + "files/" + current_file_name
        response = requests.put(url=file_upload_url, headers=file_upload_headers, data=current_file_handle)
        if not response.ok:
            print('Failed with error')
            print(response.content)
            sys.exit(6)
        else:
            print('OK')

print('DONE')


