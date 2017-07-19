APP                = curator
ROOT               = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
REQ                = requirements.txt
REQ_DOCS           = requirements_docs.txt
VIRTUALENV         ?= $(shell which virtualenv)
PYTHON             ?= $(shell which python2.7)
PIP                ?= $(shell which pip2.7)
MOLECULE_PROVIDER  = virtualbox
VENV               ?= $(ROOT)/.venv
PLATFORMS          = rhel7
SHELL              = /bin/bash

.ONESHELL:
.PHONY: test test_rhel6 test_rhel7 clean venv docs venv_docs $(VENV)

all: default

default:
	@echo
	@echo "Welcome to '$(APP)' software package:"
	@echo
	@echo "usage: make <command>"
	@echo
	@echo "commands:"
	@echo "    clean                           - Remove generated files and directories"
	@echo "    venv                            - Create and update virtual environments"
	@echo "    test PLATFORM=($(PLATFORMS))    - Run test on specified platform"
	@echo "    syntax                          - Run syntax checks"
	@echo "    del PLATFORM=($(PLATFORMS))     - Remove specified platform"
	@echo "    ansiblelint                     - Run ansible-lint validations
	@echo "    yamllint                        - Run yamlint validations
	@echo

venv: $(VENV)

$(VENV): $(REQ)
	@echo ">>> Initializing virtualenv..."
	mkdir -p $@; \
	[ -z "$$VIRTUAL_ENV" ] && $(VIRTUALENV)  --no-site-packages  --distribute -p $(PYTHON) $@; \
	$@/bin/pip install --exists-action w -r $(REQ);

linkrole:
	@mkdir -p roles/ ; rm -rf roles/$(APP) 2>/dev/null; 	ln -sf ../ roles/$(APP)

ansiblelint: venv
	@echo ">>> Executing ansible lint..."
	@[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	ansible-lint -r ansible-lint -r $(VENV)/lib/python2.7/site-packages/ansiblelint/rules playbook.yml

yamllint: venv
	@echo ">>> Executing yaml lint..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	yamllint tasks/* vars/* defaults/* meta/* handlers/*

lint: yamllint ansiblelint

delete:
	@echo ">>> Deleting $(PLAFORM) ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	molecule destroy --platform=$(PLATFORM);

test: venv linkrole delete
	@echo ">>> Runing $(PLAFORM) tests ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	PYTEST_ADDOPTS="--junit-xml junit-$(PLATFORM).xml --ignore roles/$(APP)" molecule test --platform=$(PLATFORM);

create:
	@echo ">>> Runing $(PLAFORM) create ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	molecule create --platform=$(PLATFORM);

converge:
	@echo ">>> Runing $(PLAFORM) converge ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	molecule converge --platform=$(PLATFORM);

syntax: venv linkrole delete
	@echo ">>> Runing $(PLAFORM) tests ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	molecule syntax;

idempotence:
	@echo ">>> Runing $(PLAFORM) idempotence ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	molecule idempotence --platform=$(PLATFORM);

verify:
	@echo ">>> Runing $(PLAFORM) verify ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	PYTEST_ADDOPTS="--junit-xml junit-$(PLATFORM).xml --ignore roles/$(APP)" molecule verify --platform=$(PLATFORM);

docs: venv_docs
	@echo ">>> Generating documentation ..."
	[ -z "$$VIRTUAL_ENV" ] && source $(VENV)/bin/activate; \
	cd docs && make clean && make rst; \
	pandoc --from=rst --to=markdown --output=../README.md _build/rst/index.rst


venv_docs: $(REQ_DOCS)
	@echo ">>> Initializing virtualenv..."
	mkdir -p $(VENV); \
	[ -z "$$VIRTUAL_ENV" ] && $(VIRTUALENV)  --no-site-packages  --distribute -p $(PYTHON) $(VENV); \
	source $(VENV)/bin/activate; $(VENV)/bin/pip install --exists-action w -r $(REQ_DOCS);


clean:
	@echo ">>> Cleaning temporal files..."
	rm -rf .cache/
	rm -rf $(VENV)
	rm -rf junit-*.xml
	rm -rf tests/__pycache__/
	rm -rf .vagrant/
	rm -rf .molecule/
	@echo
