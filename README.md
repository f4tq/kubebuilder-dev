# kubebuilder-dev assists in the development of kubenetes controllers
It provides assistence in generating stubs that can be used with kubebuilder.
In the case of istio, this is no small feat as istio.io/api has crazy tight dependencies that.
With this project and github.com/f4tq/istio-api-mod, you can generate stubs that can be referenced from kubebuilder (k8s-runtime-controller) from kubernetes-1.13.

- go 1.11

> With GOMODULES11=on

- dep
- golang protobuf (protoc)
- gogo protobuf
- istio/tools/cmd
- k8s code-generator
- istio protoc-gen-docs
- and the obscure but required protoc-gen-jsonshim used to generate kubernetes wrappers for arbitrary structs (usuall *.pb.go files)
- kubectl
- protobuf tools
- kubebuilder (pass KUBEBUILDER_VER ) to make to override 1.0.8
- kustomize 1.0.11

- a kube config converter so the .kube/config doesn't contain references to external files as with minikube


- Building Dev container

`make build-container`

- Deleting Dev container

`make delete-build-container`

- Get a shell

> Note: Mounting the current directory, project your ssh-agent, ~/.kube directory, and creating a .bash_history for the project in `~/.bash-history/$(basename $(pwd))` 


## Running 

### f4tq/istio-api
Checkout out [f4tq/istio-api-mod](https://github.com/f4tq/istio-api-mod)

- Run
```
# cd istio-api-mod
# Reference the Makefile.istio-api
- get a shell in the env
```
make -f ~/go/src/github.com/f4tq/kubebuilder-dev/Makefile.istio-api  PKG=github.com/f4tq/istio-api-mod shell

```
- run the `generate` target.
You'll want to do this if you need a particular k8s.io/apimachinery