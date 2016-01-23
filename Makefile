# Makefile for Zookeeper Docker Image Builder
# Version 1.0
# Samuel Ng
#
# default: all

PACKAGE_DIR := $(dirname "$(readlink -f "$0")")

all: latest

latest:
	@./tasks/download_zookeeper.sh ||:
	@tar -czh . | docker build --rm -t zookeeper -
