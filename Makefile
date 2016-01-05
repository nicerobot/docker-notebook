.PHONY: build run editor notebook all anaconda anaconda3 volumes

build: anaconda volumes
	docker build -t nicerobot/notebook .

run editor notebook:
	docker run -p 8888:8888 -d nicerobot/notebook notebook --no-browser

anaconda anaconda3: docker-anaconda3/Dockerfile
	cd docker-anaconda3; $(MAKE)

docker-anaconda3/Dockerfile:
	git submodule update --init

volumes:
	docker create -v /notebooks --name notebooks nicerobot/notebook /bin/true; true
