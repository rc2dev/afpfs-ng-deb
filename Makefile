IMAGE = afpfs-ng-deb
DOCKER_DIR = $(PWD)/docker
PATCHES_DIR= $(PWD)/patches
DIST = $(PWD)/dist


.PHONY: build-image package clean 

all: package

build-image: 
	docker build -t $(IMAGE) $(DOCKER_DIR)

package: build-image
	mkdir -p $(DIST)
	docker run \
		-v $(DIST):/app/dist \
		-v $(PATCHES_DIR):/app/patches \
		$(IMAGE)

clean:
	sudo rm -rf $(DIST)/*
