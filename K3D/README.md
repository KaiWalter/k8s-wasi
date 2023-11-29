# K3D

## general guide

- <https://nigelpoulton.com/webassembly-on-kubernetes-ultimate-hands-on/>
- <https://github.com/deislabs/containerd-wasm-shims/blob/main/deployments/k3d/README.md#how-to-run-the-example>

```shell
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

```shell
k3d cluster create wasm-cluster \
--image ghcr.io/deislabs/containerd-wasm-shims/examples/k3d:v0.5.1 \
-p "8081:80@loadbalancer" --agents 2
```

...

### build from deislabs/containerd-wasm-shims

install Rust toolchain

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

```shell
git clone git@github.com:deislabs/containerd-wasm-shims.git
cd ./deployments/k3d
make up
make test
make clean
```

## with Dapr

- <https://dev.to/thangchung/how-to-run-webassemblywasi-application-spin-with-dapr-on-kubernetes-2b8n>

```
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d cluster create wasm-cluster --image ghcr.io/deislabs/containerd-wasm-shims/examples/k3d:v0.9.0 -p "8081:80@loadbalancer" --agents 2
kubectl apply -f https://github.com/deislabs/containerd-wasm-shims/raw/main/deployments/workloads/runtime.yaml
kubectl apply -f https://github.com/deislabs/containerd-wasm-shims/raw/main/deployments/workloads/workload.yaml
echo "waiting 5 seconds for workload to be ready"
sleep 15
curl -v http://127.0.0.1:8081/spin/hello
curl -v http://127.0.0.1:8081/slight/hello
curl -v http://127.0.0.1:8081/wws/hello
curl -v http://127.0.0.1:8081/lunatic/hello
```
