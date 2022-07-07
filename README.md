<p align="center">
<img src="https://xmrig.com/assets/img/xmrig-logo.svg" width="200">
</p>

# [XMRig](https://xmrig.com/)

This repository containerizes the XMRig mining software which runs the [RandomX](https://www.getmonero.org/resources/moneropedia/randomx.html) Proof-of-Work algorithm. 

## [Building](https://xmrig.com/docs/miner/build/ubuntu)

To build the XMRig image locally:

```shell
docker build -t xmrig .
```

You can pull a pre-built image from `tthebc01/xmrig`

```shell
docker pull tthebc01/xmrig
```

## Starting XMRig

You will need the following information handy to start the container:

1. The address and port of the [stratum](https://en.bitcoinwiki.org/wiki/Stratum_mining_protocol) server for the pool you want to mine with. Some popular choices are [MineXMR](https://minexmr.com/miningguide), [MoneroOcean](https://moneroocean.stream/), or [Nanopool](https://nanopool.org/).
2. The address of the wallet you want to receive you mining rewards in.
3. A name for your mining rig. 

```shell
docker run -d --rm --env POOL=us-west.minexmr.com --env PORT=443 --env RIG_ID="cyberskull" --env WALLET=4BXXX --gpus all tthebc01/xmrig
```