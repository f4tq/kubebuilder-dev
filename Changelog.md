#v0.1
- introducing build container providing capabilities to other projects that can be relied upone
##v0.1 has the following capabilities
- go 1.11
- GO111MODULES=on
- vend to vendor /go/pkg into the project.  Istio-tools really needs this.
- kustomize - weak version of gomplate
- kubebuilder - defaults to 1.0.8 but can be overriden
- protoc 3
- f4tq/gomplate with *generic* helm like support for nested go templates.  [See](https://github.com/f4tq/gomplate/releases) for use.  Used heavily within Adobe.
-
