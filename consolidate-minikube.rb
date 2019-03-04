#!/usr/bin/env ruby
# given a minikube yaml file using external references to keys, consolidate if for use by docker

require "json"
require "yaml"
require "base64" 
mp=YAML.load(STDIN.read); 
mp["clusters"][0]["cluster"]["certificate-authority-data"]= Base64.encode64(File.read(mp["clusters"][0]["cluster"]["certificate-authority"]))
mp["users"][0]["user"]["client-certificate-data"]= Base64.encode64(File.read(mp["users"][0]["user"]["client-certificate"]))
mp["users"][0]["user"]["client-key-data"]= Base64.encode64(File.read(mp["users"][0]["user"]["client-key"]))

mp["users"][0]["user"].delete "client-key"
mp["users"][0]["user"].delete "client-certificate"
mp["clusters"][0]["cluster"].delete "certificate-authority"

puts mp.to_json

