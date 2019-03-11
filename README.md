# kubebuilder-dev assists in the development of other kubenetes controllers

It can build kubebuilder through 1.0.8
It provides assistence in generating istio 1.0xx stubs that can be used with kubebuilder.
### Why
For istio/api, there are WAY too many dependencies that prohibit the re-use of istio/api in other go projects.
This project, and github.com/f4tq/istio-tools, github.com/f4tq/istio-api-mod provide a way to directly drop istio/api into kubebuilder projects that would otherwise be able to use istio/api by constraint.

For kubebuilder, just a consistent way to build various versions of kubebuilder without install golang or anything else except docker and make.

### Provides

- go 1.12

- dep
- golang protobuf (protoc)
- gogo protobuf
- istio/tools/cmd
- k8s code-generator
- istio protoc-gen-docs
- protoc-gen-jsonshim with modifications from f4tq/istio-tools@protoc-gen-jsonshim
- protoc-gen-kubetype from f4tq/istio-tools@istio-8772 (an existing PR to istio/istio at the time of this writing.
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

## Using

### For istio/api (i.e. github.com/f4tq/istio-api-mod)
You only need to use the `Makefile.istio-api` if you want to generate your own stubs for your own package.

`github.com/f4tq/kubebuilder-dev` provides a convenience `Makefile.istio-api` which essentially proxies Makefile targets in `github.com/f4tq/istio-api-mod` through the docker image of this project.

- Checkout/fork github.com/f4tq/istio-api-mod

```
# cd istio-api-mod
# Reference the Makefile.istio-api

- get a shell in the env

```
make -f ~/go/src/github.com/f4tq/kubebuilder-dev/Makefile.istio-api  PKG=github.com/f4tq/istio-api-mod shell

```

> NOTE: change PKG to your fork's go package name

### For kubebuilder

- build kubebuilder

```make KUBEBUILDER=1.0.6 build-dev-container` will make a docker image called `f4tq/kubebuilder-dev:1.0.6```

> With kubebuilder 1.0.6

- initialize your project

`mkdir -p yourproject`

- goto your project

`cd yourproject`

> Do stuff

- use kuberbuilder dockerimage

```
yourproject # make -f ~/go/src/github.com/f4tq/kubebuilder-dev/Makefile.kubebuilder PKG=github.com/your/project shell

/go/src/github.com/your/project # kubebuilder ...

```

> You may optionally provide your own image via `devcontainer` like
`make devcontainer=my/docker:latest -f Makefile.kubebuilder `


- run the `generate` target.

You'll want to do this if you need a particular k8s.io/apimachinery