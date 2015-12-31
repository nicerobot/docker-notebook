.PHONY: build notebook all anaconda anaconda3

build notebook: anaconda
	docker build -t nicerobot/notebook .

anaconda anaconda3: docker-anaconda3/Dockerfile
	cd docker-anaconda3; $(MAKE)

docker-anaconda3/Dockerfile:
	git submodule update --init
