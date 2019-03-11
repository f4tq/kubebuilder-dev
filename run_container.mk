define RunContainer
	@set -x ; (env | grep -e AWS -e VAULT -e AZ ) > /tmp/env-file && \
	KUBE=""; if ( env | grep -q KUBECONFIG  ); then KUBE="-v $$KUBECONFIG:/root/.kube/config" ; elif [ -d ~/.kube ]; then KUBE="-v $$(echo ~)/.kube:/root/.kube";fi ;\
	DOCKER=""; if [ ! -z "$${DOCKER_CONFIG}" ]; then DOCKER="-v $${DOCKER_CONFIG}:/root/.docker" ; fi ;\
	SSH1="" ; SSH2="" ; if [ ! -z "$$GIT_SSH_KEY" ]; then  SSH1="-e GIT_KEY=$${GIT_SSH_KEY}" ; elif  [ ! -z "$${SSH_AUTH_SOCK}" ] ; then SSH1="-e SSH_AUTH_SOCK=/root/.foo -v $$SSH_AUTH_SOCK:/root/.foo" ; fi;\
	target="$$(echo '$(1)')" ;\
	if [  'shell' == "$$target" ] ; then \
		: $${HIST:=$$HOME/.bash_history-$(basename)}; if [ ! -f $$HIST ]; then touch $$HIST; fi ; DEVMODE="-v $$HIST:/root/.bash_history -e HISTSIZE=100000 " ;\
		docker run --net=host -it --rm  -e PKG=$(PKG) $$SSH1 $$SSH2 $$DOCKER $$KUBE $$DEVMODE --env-file /tmp/env-file  -v $(shell pwd):/go/src/$(PKG) -w /go/src/$(PKG) $$D2 $(devcontainer)  ;\
	else \
	docker run --net=host -i --rm  -e PKG=$(PKG) $$SSH1 $$SSH2 $$DOCKER $$KUBE --env-file /tmp/env-file  -v $(shell pwd):/go/src/$(PKG) -w /go/src/$(PKG) $$D2 $(devcontainer)  $$target ;\
	fi
endef

