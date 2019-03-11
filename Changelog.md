#v0.2
	- introducing build container providing capabilities to other projects that can be relied upone
	- go 12
	- add protoc-gen-jsonshim
	- add protoc-gen-kubetype
##v0.1 has the following capabilities
- go 1.11
- GO111MODULES=on
### Tools installed to /usr/local/bin	
- vend to vendor /go/pkg into the project.  Istio-tools really needs this.
  > to move mod packages from /go/pkg/mod to you package's vendor/
- kustomize - weak version of gomplate
- kubebuilder - defaults to 1.0.8 but can be overriden
- protoc 3
- k8s.io/code-generate
- f4tq/gomplate with *generic* helm like - nested go template support.  [See](https://github.com/f4tq/gomplate/releases) for use.  Used heavily within Adobe.
- ruby
	
