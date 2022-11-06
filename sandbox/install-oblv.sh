#!/bin/bash

#download the oblv proxy cli and install it.
wget "https://api.oblivious.ai/oblv-ccli/dev/packages/oblv_0.3.0_amd64.deb"
sudo dpkg -i oblv_0.3.0_amd64.deb
rm -rf oblv_0.3.0_amd64.deb
