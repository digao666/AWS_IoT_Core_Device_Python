#!/usr/bin/env bash
# stop script on error
set -e

# Check to see if root CA file exists, download if not
if [ ! -f ./root-CA.crt ]; then
  printf "\nDownloading AWS IoT Root CA certificate from AWS...\n"
  curl https://www.amazontrust.com/repository/AmazonRootCA1.pem > root-CA.crt
fi

# Check to see if AWS Device SDK for Python exists, download if not
if [ ! -d ./aws-iot-device-sdk-pytho-v2]; then
  printf "\nCloning the AWS SDK...\n"
	git clone https://github.com/aws/aws-iot-device-sdk-python-v2.git
fi

# Check to see if AWS Device SDK for Python is already installed, install if not
if ! python -c "import awsiotsdk" &> /dev/null; then
  printf "\nInstalling AWS SDK...\n"
  pushd aws-iot-device-sdk-python-v2

python3 -m pip install awsiotsdk
  result=$?
  popd
  if [ $result -ne 0 ]; then
    printf "\nERROR: Failed to install SDK.\n"
    exit $result
  fi
fi

# run pub/sub sample app using certificates downloaded in package
printf "\nRunning pub/sub sample application...\n"
python3 aws-iot-device-sdk-python-v2/samples/pubsub.py -e a1vgq6tp09249f-ats.iot.us-west-2.amazonaws.com -r root-CA.crt -c YVR_water_sensor1.cert.pem -k YVR_water_sensor1.private.key
