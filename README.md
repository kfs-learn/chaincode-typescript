# Install bun.sh

We need to install bun.sh to run the project.

```bash
curl -fsSL https://bun.sh/install | bash
```


## Install dependencies

```bash
bun install
```


## Install Node.JS using NVM

FIrst, we need to install NVM:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

Then, we need to install Node.JS using NVM:

```bash
nvm install v22
nvm use default v22
```


# Start chaincode

To start the chaincode, we need to pull the network configuration and start the chaincode.

```bash

export CHANNEL_NAME=testnetwork2
export MSP_ID=Org1MSP
export URL="http://localhost:8100/api/v1"
export CHAINLAUNCH_USERNAME=admin
export CHAINLAUNCH_PASSWORD="YxEIAObvsDg3"

chainlaunch fabric network-config pull --network=$CHANNEL_NAME --msp-id=$MSP_ID --url=$URL --username="$CHAINLAUNCH_USERNAME" --password="$CHAINLAUNCH_PASSWORD" --output=network-config.yaml


export CHANNEL_NAME=testnetwork2
export CHAINCODE_NAME=basic
export CHAINCODE_ADDRESS="localhost:9996" # this is the address where the chaincode will be listening
export USER_NAME=admin
export MSP_ID=Org1MSP

chainlaunch fabric start --local --config=$PWD/network-config.yaml \
    --channel=$CHANNEL_NAME --chaincode=$CHAINCODE_NAME \
    -o $MSP_ID -u $USER_NAME \
    --policy="OR('${MSP_ID}.member')"  \
    --chaincodeAddress="${CHAINCODE_ADDRESS}" --envFile=$PWD/.env


bun run build
bun start:dev

export CHANNEL_NAME=testnetwork2
export CHAINCODE_NAME=basic
export MSP_ID=Org1MSP

chainlaunch fabric invoke --chaincode=$CHAINCODE_NAME --config=network-config.yaml \
    --channel $CHANNEL_NAME --fcn InitLedger  --user=admin --mspID=$MSP_ID

chainlaunch fabric query --chaincode=$CHAINCODE_NAME --config=network-config.yaml \
    --channel $CHANNEL_NAME --fcn GetAllAssets  --user=admin --mspID=$MSP_ID
```
