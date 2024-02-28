### Smart Contract 

#### 说明

基于ERC721标准发行DiscoverLive pass nft 为唯一凭证
```shell
### 编译
cd DiscoverLive

### Start docker devnet locallly
docker run -dti 5050:5050 shardlabs/starknet-devnet-rs --name localstarknet

## create new account
sncast \
  --url http://127.0.0.1:5050 \
  account create \
  --name DiscoverLiveDeployer

sncast \
  --url http://127.0.0.1:5050 \
  account deploy
  --name DiscoverLiveDeployer \
  --max-fee 864600000000

## Build contract
scarb build


## declare contract
sncast --account myuser \
    --url http://127.0.0.1:5050/rpc \ 
    declare \
    --contract-name DiscoverLive

## deploy contract
sncast \
    --account myuser \
    --url http://127.0.0.1:5050/rpc \
    deploy \
    --class-hash [declare hash]




```
