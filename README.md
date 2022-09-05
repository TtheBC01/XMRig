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

You can pull a pre-built image from `tthebc01/xmrig` that is based on [`nvidia/cuda:11.4.0-runtime-ubuntu:18.04`](https://hub.docker.com/layers/nvidia/cuda/11.4.0-runtime-ubuntu18.04/images/sha256-4dfdfec42da3308b94d1f9886f3db1593032c2a8a78586f900c5e29ffa496577?context=explore)

```shell
docker pull tthebc01/xmrig
```

### Customizing the CUDA version

If you are going to use your GPU with this image, you will need to make sure the host CUDA version and container CUDA versions match. Check what CUDA release you are using:

```shell
nvidia-smi
```

Then build with an appropriate base image using the build-time arg `CUDAVERSION`:

```shell
docker build -t xmrig --build-arg CUDAVERSION=11.4.0 .
```

## Starting XMRig

You will need the following information handy to start the container:

1. The address and port of the [stratum](https://en.bitcoinwiki.org/wiki/Stratum_mining_protocol) server for the pool you want to mine with. Some popular choices are [MineXMR](https://minexmr.com/miningguide), [MoneroOcean](https://moneroocean.stream/), or [Nanopool](https://nanopool.org/).
2. The address of the wallet you want to receive you mining rewards in.
3. A name for your mining rig. 

```shell
docker run -d --rm --env POOL=us-west.minexmr.com --env PORT=443 --env RIG_ID="cyberskull" --env WALLET=4BXXX --gpus all tthebc01/xmrig
```
