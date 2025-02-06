# Install bun.sh

We need to install bun.sh to run the project.

```bash
curl -fsSL https://bun.sh/install | bash
```


## Install dependencies

```bash
bun install
```



# Start chaincode

To start the chaincode, we need to pull the network configuration and start the chaincode.

```bash

export NETWORK_ID=23
export ORG_ID=1
export URL="http://localhost:8100/api/v1"
export CHAINLAUNCH_USERNAME=admin
export CHAINLAUNCH_PASSWORD="bGHiYctpsQ6k"

chainlaunch fabric network-config pull --network-id=$NETWORK_ID --org-id=$ORG_ID --url=$URL --username="$CHAINLAUNCH_USERNAME" --password="$CHAINLAUNCH_PASSWORD" --output=network-config.yaml


export CHANNEL_NAME=testdemo1
export CHAINCODE_NAME=basic
export CHAINCODE_ADDRESS="localhost:9996" # this is the address where the chaincode will be listening
export USER_NAME=admin
export MSP_ID=Org1MSP

fabric-chaincode-dev start --local --config=$PWD/network-config.yaml \
    --channel=$CHANNEL_NAME --chaincode=$CHAINCODE_NAME \
    -o $MSP_ID -u $USER_NAME \
    --policy="OR('${MSP_ID}.member')"  \
    --chaincodeAddress="${CHAINCODE_ADDRESS}" --envFile=$PWD/.env


bun start:dev

fabric-chaincode-dev invoke --chaincode=$CHAINCODE_NAME --config=network-config.yaml \
    --channel $CHANNEL_NAME --fcn InitLedger  --user=admin --mspID=$MSP_ID

fabric-chaincode-dev query --chaincode=$CHAINCODE_NAME --config=network-config.yaml \
    --channel $CHANNEL_NAME --fcn GetAllAssets  --user=admin --mspID=$MSP_ID
```
