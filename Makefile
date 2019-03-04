makefile_dir := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
#makefile_dir :=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
current_dir := $(shell pwd)
basename := $(shell basename $(current_dir))
KUBEBUILDER_VER ?= 1.0.8
devcontainer ?= f4tq/kubebuilder:${KUBEBUILDER_VER}
shell_version=$(shell cat $(makefile_dir)/SHELL_VERSION)
dev_targs:= $(shell docker images  | grep -v REPOSITORY | awk '{ printf("%s:%s\n",$$1,$$2)}'  | grep  "$(devcontainer)" )

ifeq ("","$(wildcard /.dockerenv)")

help:
	@echo "current directory: $(current_dir)"
	@echo "makefile_dir: $(makefile_dir)"
	@echo "devcontainer: $(devcontainer)"
	@echo "kubebuilder version: $(KUBEBUILDER_VER)" ; echo ; echo "Use make build-container|delete-build-container|shell"
	@echo "dev_targs: $(dev_targs)"

SHELL:=/bin/bash

include $(makefile_dir)/run_container.mk

all: build-container

shell:
	$(call RunContainer,shell)

build-container: 
	@cd $(current_dir) ; \
	set -x; if  !(docker images  | grep -v REPOSITORY | awk '{ printf("%s:%s\n",$$1,$$2)}'  | grep -q "$(devcontainer)" ) ; then\
		if [ ! -e /.dockerenv -o ! -z "$$JENKINS_URL" ]; then \
			if [ ! -z "$(debug)" ]; then \
			echo "------------------------------------------------" ; \
			echo "$@: Building dev container image..." ; \
			echo "------------------------------------------------" ; \
			fi ;\
			docker pull $(devcontainer) || docker build --no-cache --build-arg shell_ver=$(shell_version) --build-arg kubebuilder_ver=$(KUBEBUILDER_VER) --build-arg package=$(PKG) -f $(makefile_dir)/Dockerfile-dev -t $(devcontainer) . ; \
		fi ; \
	fi



delete-build-container:  ## Delete the dev container
delete-build-container:
	@set -x; if (docker images  | grep -v REPOSITORY | awk '{ printf("%s:%s\n",$$1,$$2)}'  | grep -q "$(devcontainer)" ) ; then \
		docker rmi $(dev_targs)  ;\
	fi
else
$(warning "Nothing will happen from within a docker container")

endif

