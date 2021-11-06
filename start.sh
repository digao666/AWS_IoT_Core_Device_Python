#!/usr/bin/env bash
# stop script on error
set -e

# Check to see if root CA file exists, download if not
if [ ! -f ./root-CA.crt ]; then
  printf "\nDownloading AWS IoT Root CA certificate from AWS...\n"
  curl https://www.amazontrust.com/repository/AmazonRootCA1.pem > root-CA.crt
fi

# Check to see if AWS Device SDK for Python exists, download if not
#if [ ! -d ./aws-iot-device-sdk-pytho-v2]; then
# printf "\nCloning the AWS SDK...\n"
#	git clone https://github.com/aws/aws-iot-device-sdk-python-v2.git
#fi

# Check to see if AWS Device SDK for Python is already installed, install if not
#if ! python -c "import awsiotsdk" &> /dev/null; then
#  printf "\nInstalling AWS SDK...\n"
#  pushd aws-iot-device-sdk-python-v2

#python3 -m pip install awsiotsdk
#  result=$?
#  popd
#  if [ $result -ne 0 ]; then
#    printf "\nERROR: Failed to install SDK.\n"
#    exit $result
#  fi
#fi

# run pub/sub sample app using certificates downloaded in package
printf "\nRunning pub/sub sample application...\n"
python3 samples/pubsub.py --endpoint a1vgq6tp09249f-ats.iot.us-west-2.amazonaws.com --root-ca root-CA.crt --cert YVR_water_sensor2.cert.pem --key YVR_water_sensor2.private.key
