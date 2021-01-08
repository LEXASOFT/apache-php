NAME = lexasoft/apache-php

default: build

build:
	docker build -t $(NAME):latest .
	docker build -t $(NAME):8.0 8.0
	docker build -t $(NAME):7.4 7.4
	docker build -t $(NAME):7.3 7.3
	docker build -t $(NAME):7.2 7.2
	docker build -t $(NAME):7.1 7.1

latest:
	docker build -t $(NAME):latest .
