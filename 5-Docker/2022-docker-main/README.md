# Linux update 
  -  sudo apt update (update all repos)

## How To Use Docker To Make Local Development A Breeze

Docker is a very powerful tool for developing applications that run in the cloud. If you want to get the most out of it, you need to make sure that the way you're running your code locally matches as closely as possible with how it runs in the cloud.

Today I'm going to show you how to do this, using a simple API server in Python as an example.

Video: https://youtu.be/zkMRWDQV4Tg.

## Usage

As a first step, install Docker (see: https://www.docker.com) and install the requirements:

```
pip install -r requirements.txt
```

This is how you run the code locally (without Docker):

```
uvicorn main:app --host 0.0.0.0 --port 8080 --reload
```

Build and run the Docker image locally, as follows:

```
docker build -t channel-api .
docker run -d -p 8080:80 channel-api
```

In order to run the example server with docker compose, use this:

```
docker-compose up --build
```

If you use docker compose and you make a minor change in the file, you can now see how everything is updated and the server is restarted automatically.

- Run code locally matches how run code in cloud else incompatibility issues
- Ex. Simple API server in Python
- Use uvicorn that allows you to run a server and expose to port
- command -> uvicorn main:app --host 0.0.0.0 --port 8080 --reload

- Docker
    - Allows to run apps in isolated env (container running preferred Linux dist)
    - create image with preinstalled software like VM
    - run locally or integrate with kubernetes
    - diff env app will run (ex. DTAP - Dev, Test, Acceptance and Prod)
    - Same docker image runs on diff env - reduce chance of code run locally to run on any env
    - Make env multiple developers working in as similar as possible
    - docker demon - run in background, mantain containers 
    - docker provide which linux version and what depedencies to install and docker understands it
    - create docker image -> run as container locally or on server or cloud
    - specification of docker image in DockerFile
    - docker create image based on file 
        - docker build -t channel-api .
    - create local container to run image locally 
        - docker run -d -p 8080:80 channel-api   #-d -> detached so get terminal back
    - if make changes to script, then delete docker container, rebuild and rerun for changes to reflect
    - alternate better way would be using docker compose 
    - tell kubernetes or any container orchastration system to update running image to next version -> using CI - github workflows 
    - docker compose
        - supply custom run cmd automatic pick up changes 
        - sync folder in your machine using volume on docker container 
        - supply yaml file here
        - volumes -> mapping current folder to app folder inside docker container - synch changes - files updates so uvicorn detect changes 
        - docker-compose up --build 
    - Deal with changes in data 
        - specify to uvicorn what files to watch for changes (pip install watchfiles)

- Docker Video 2 -> https://www.youtube.com/watch?v=eGz9DS-aIeY
- Replace VM
- VM
    - Virtualization - install hypervisor
    - hypervisor -> divide server resources in multiple servers, popular ex VMWare (esxi)
    - virtualizes hardware


    WinServer   Ubuntu  CentOS  Debian
    Hypervisor (VMWare)
    Hardware

- Docker container
    - install one OS to access all resources
    - virtualizes OS

    CentOS  Debian  Ubuntu  (Containers)
    Docker Engine
    Ubuntu (OS)
    Hardware

    - containers are crazy fast light weight computers, have its own OS, CPU,Memory, and Network -> Isolated.
    - Lab 
    - Install centos
    docker pull centos
    Go to docker hub -> registry of docker images, image used to run/create our containers, 
    docker run -d -t --name cantcontainmyself centos 
    docker ps   (See running containers)
    docker exec -it cantcontainmyself bash(play with docker container via bash shell)
    exit (quit out of docker centos)
    - install alpine
    docker pull alpine
    docker run -t -d --name ohyeah alpine
    docker ps
    docker exec -it ohyeah sh (connect to shell for alpine)
    - install bunch of things -> diff flavors of ubuntu, wordpress on same machine
    - install custom docker image created on hub.docker.com 
    docker pull thenetworkchuck/nccoffee:frenchpress   (tag reflect diff version of image) -> has OS, CPU, Memory, website config, settings -> packaged as container
    docker run -d -t -p 80:80 --name nccoffee thenetworkchuck/nccoffee:frenchpress   (p to map ports -p host:dockercontainer)
    docker ps 
    Go to IP for machine -> docker container running website IMA 
    docker stop nccoffee (stop docker container)
    docker start nccoffee (start docker container again)
    docker stats (show how much CPU/Memory/Network used)
    - install nginx
    docker run -itd -p 80:80 nginx
    - ex container 
        -> Debian-Linux
           NGinx 
           -> Website files
           -> All depedencies 
    - Why docker ?
    - portabkle run everywhere 
    - diff images for diff versions - diff ubuntu version images 
    - Why fast and lightweight ?
    fast -> only need 1 kernel that is up and running (share same linux kernel)
    lightweught -> need 1 kernel only for all linux OS, less parts to run
    install windows based container on windows system and linux based container on linux system because share same underlying OS / kernel 
    - control group decide on resources given to each container
    - isolate everything with namespace
    - How industry using docker ?
    docker container put to any cloud, write code and deploy in container and that works 
    everywhere, 
    - Microservices ?
    taking portions of your application / stack and segmenting to smaller code pieces, 
    traditionally install app everything on 1 server
    but now containers 1 app -> have diff components on diff containers, update siloed container
    - create docker volume for storing persistant information
    docker volume create portainer_stuff
    docker run -d -p 9443:9443 -p 8000:8000 --nmae portainer --restart=always 
    -v /var/run/docker.sock:/var/run/docker.cok -v portainer_data:/data portainer/portainerce:latest   (-v maps volume from local to docker container)

    - Execute and go inside a docker container
    docker exec -it <name> sh




    - docker compose 
    build dockorized env with 1 command / file
    - install docker and docker compose 
        sudo apt install docker.ip docker-compose -y 
    - create and run docker
        sudo docker run --name web -itd -p 8080:80 nginx
    - do above command using docker compose -> work with folder dedicated to docker compose
        mkdir coffeetime
        cd coffeetime
        nano docker-compose.yaml    (yaml -> data serialization language, config file)

        In file ->
        version: "3"
        services: 
            website:
                image:nginx
                ports:
                    - "8081:80"
                restart: always 

        sudo docker-compose up -d     (-d -> keep it running in background in folder where created else use -f)

        sudo docker-compose ps    (show docker containers in compose env only)

        sudo docker-compose down   (deletes everything)
        sudo docker-compose stop

    - create containers and networks using file 
    #create network -> sudo docker network create coffee --subnet 192.168.92.0/24
    In file ->
        version: "3"
        services: 
            website:
                image:nginx
                ports:
                    - "8081:80"
                restart: always     
            website2:
                image:nginx
                ports:
                    - "8082:80"
                restart: always 
                networks:
                    coffee:
                        ipv4_address: 192.168.92.21
        networks:
            coffee:
                ipam:                       #ip address management
                    driver: default         #bridge 
                    config:
                        - subnet: "192.168.92.0/24"


        docker inspect coffee    #inspect network

    - deploy wordpress with docker compose 
        - frontend (web)  - container 
        -  database (mysql) - container 
        and then connect them 

    nano docker-compose.yaml

    version: "3"
    services:
        wordpress:
            image: wordpress
            ports:
                - "8089:80"
            depends_on:
                - mysql
            environment:
                WORDPRESS_DB_HOST: mysql
                WORDPRESS_DB_USER: root
                WORDPRESS_DB_PASSWORD: "coffee"
                WORDPRESS_DB_NAME: wordpress
            networks:
                ohyeah:
                    ipv4_address: "10.56.1.21"
        mysql:
            image: "mysql:5.7"
            environment:
                MYSQL_DATABASE: wordpress
                MYSQL_ROOT_PASSWORD: "coffee"
            volumes:                              # map docker dir to local dir on system
                - ./mysql:/var/lib/mysql          # local : docker 
            networks:
                ohyeah:
                    ipv4_address: "10.56.1.20"
        networks:
            ohyeah:
                ipam:
                    driver: default

        sudo docker-compose up -d    -> get wordpress side working

        Open site -> localhost:8089



- Docker Networking (7 Docker Networks)
    - add container on host -> how show up on network
    - 7 types of network deploy with docker 
    - the default bridge
        - ip address show    (show network addresses)
        - docker0 interface (virtual bridge)
        - sudo docker network ls  (list docker networks)
        - sudo docker run -itd --rm --name thor busybox
        - sudo docker run -itd --rm --name mjolnir busybox
        - sudo docker run -itd --rm --name stormbreaker nginx
        - sudo docker ps
        - by default, containers thrown in bridge network, create virtual ethernet interfaces and connected to bridge 
        - bridge link   (show name and connected to bridge)
        - running DHCP & has DNS here as each container has its own IP address
            - docker inspect bridge 
            - get copy of /etc/resolv.conf from host and puts it in each docker container
            - docker container on same host can talk to each other
            - use nat masquarade for docker container to talk to internet
            - cannot access ports in docker container from host . Ex. website, manually expose those ports 
            - sudo docker run -itd --rm -p 80:80 --name stormbreaker nginx  (expose port to host)
    - the user defined bridge
        - sudo docker network create asgard
        - ip address show   ( new virtual bridge with network created)
        - sudo docker run -itd --rm --network asgard --name loki busybox
        - sudo docker run -itd --rm --network asgard --name odin busybox
        - ip address show   (virtual interfaces created)
        - bridge link   (interface tied to bridge created)
        - sudo docker inspect asgard   (asgard isolated from default)
        - get container container DNS (ping by name, ex in loki -> ping odin)
    - the HOST
        - sudo docker run -itd --rm --network host --name stormbreaker nginx
        - not expose any ports 
        - stormbreaker move right next to host, share IP address and port of host, not reqd to expose any ports
        - container basically running as a host
        - run app directly connected to the host network 
        - downside -> no isolation
    - Mac VLAN
        - connect docker container directly to physical network
        - ethernet interface of docker connecting directly to switch on house - get their own MAC address and IP address on home network , act like VM
        - sudo docker network create -d macvlan -- subnet 10.7.1.0/24 \   (my home network)
        --gateway 10.7.1.3 \  (router)
        -- -o parent=enp0s3 \  (tie macvlan to host network interface - physical NIC connected to network)
        newasgard     (name of network)

        - sudo docker stop thor mjorlnir
        - sudo docker run -itd --rm --network newasgard --ip 10.7.1.92 --name thor busybox    (assign IP address ourself not being used in network)
        - sudo docker exec -it thor sh 
        - ip address show      (see physical ip address here)
        - ping defaulytgateway (doesnt work)
        - problem network not have multiple mac address on 1 switchboard so need to enable promiscous mode (enable on network interface)
        - sudo ip link set enp0s3 promisc on
        - enable from VM box   (change on each network device)
        - benefits of bridge network and connected to home network
        - no need to expose any ports as docker has its own IP
        - downside
            - no DHCP, connect to home network - not get from home router. docker by default assign dhcp - conflict so specify ip address or ip range
            - promiscous mode set up for each network interface
        - 2 modes
            - bridge mode above connect to your network
            - 802.1q mode
                - connect container direct to network
                - specify sub interface eth0.20, eth0.30 
                - router on a stick with docker as host
                - sudo docker network create -d macvlan \
                  --subnet 192.168.20.0/24 --gateway 192.168.20.1 
                  --o parent=enp0s3.20 macvlan20
                - ip address show   (creates new sub interface)
    - the IP Vlan 
        - l2 mode (fixes promiscous issue)
            - allow host to share mac address with container
            - 1 mac address with multiple ip addresses
            - sudo docker network create -d ipvlan \
              --subnet 192.168.20.0/24 --gateway 192.168.20.1 
              --o parent=enp0s3.20 macvlan20
            - sudo docker run -itd --rm --network newasguard \
              --ip 10.7.1.92 --name thor busybox          (still need to provide IP)
            - l2 -> mac addresses and ARP respones

        - l3 mode
            - all about layer 3 -> ip address and routing
            - container connecting to host such that host is a router 
            - docker network connection to outside world will be l3 
            - get control - isolation with containers via l3 (networks)
            - control who reach them
            - sudo docker network create -d ipvlan \
              --subnet 192.168.94.0/24  (gateway will be the parent interface we tie to)
              --o parent=enp0s3.20 -o iplvlan_mode=l3 \
              --subnet 192.168.95.0/24 \
              newasguard
            - sudo docker run -itd --rm --network newasguard \
              --ip 192.168.94.7 --name thor busybox   (IP belong to subnet)
            - sudo docker run -itd --rm --network newasguard \
              --ip 192.168.94.8 --name mjolnir busybox   (IP belong to subnet)
            - sudo docker run -itd --rm --network newasguard \
              --ip 192.168.95.7 --name loki busybox   (IP belong to subnet)
            - sudo docker run -itd --rm --network newasguard \
              --ip 192.168.95.8 --name odin busybox   (IP belong to subnet)
            - container ping other container in another subnet in l3 mode, seperate networks share the same parent interface. for isolation connect to diff physical network interface
            - add static route to network -> router how get to docker network
            - ping google.com from docker container now
            - turn host to router allowing you to create docker container networks that are layer 3 only
    - overlay network 
        - for diff hosts
        - multiple hosts running bunch of containers across diff machines 
        - docker swarm (similar to kubernetes)
        - overlay makes rules on how those containers can talk to each other
    - none network
        - by default craeted 
        - sudo docker run -itd --rm --network_name none --name gorr busybox
        - sudo docker exec -it gorr sh
        - ip address show (just have loopback)
- Docker Volume 
    - Data persistence (databases or other stateful applications)
    - Ex. Database container with virtual file system data stored -> /var/lib/mysql/data
    - but no persistence when restart / remove container
    - need to save changes app making on database so use docker volume 
    - On Host system, physical file system map to virtual file system docker
    - /home/mount/data -> /var/lib/mysql/data (Folder in physical host file system is mounted into virtual file system of docker)
    - Container restarts and gets data from Host file system
    - 3 types of docker volumes
        - Host volume (decide which file system on host map to container)
        - docker run -v /home/mount/data:/var/lib/mysql/data    (host:container)
        - Anonymous Volumes (Volume by referencing container directory only)
        - docker run -v /var/lib/mysql/data    
        - host volume created automatically by docker -> /var/lib/docker/volumes/random-hash/_data
        - Named Volumes (Anonymous volume with name specified)  --- USE PREFERENCE
        - docker run -v name:/var/lib/mysql/data
        - reference volume by name
    - docker volume in docker compose 
    - Ex.
    - monge-docker-compose.yaml
    version: '3'
    services:
        mongodb:
            image: mongo
            ports:
                - 27017:27017
            volumes:
                - db-data:/var/lib/mysql/data
        mongoexpress:
            image: mongo-express
            ...
    volumes:
        db-data
    - Docker Volume located based on OS -
        - Windows -> C:\ProgramDara\docker\volumes
        - Linux -> /var/lib/docker/volumes
        - Mac -> /var/lib/docker/volumes (creates linux VM and stores all data here)
          so execute command ->
          screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.and64-linux(tty)  -> get terminal of VM  - do ls.
          end sessiobn - ctrl+a+k and then y
    - volume has hashes - containers share docker volumes across. 


- Workflow with Docker
    - Development
    - Continous delivery
    - Deployment
- Ex.
Mongodb (DockerHub)  
Developing JS app (local) ->  Git   -> CI  --push-> Docker repository  -> Dev Server (JS Custom Container and MongoDB container from Docker Hub) -> Dev Server pulls both images 

CI -> builds JS app & creates Docker Image
- Ex. 1                           Isolated Docker Network
JS localhost:27017 ------>   MongoDB -> Mongo Express UI

- Ex. 2                                    Isolated Docker Network 
Web Browser localhost:3000 ------->  NodeJS -> MongoDB  ->  Mongo Express UI
 
1. docker network create mongo-network

2. 
docker run -p 27017:27017 \
-d \ 
-e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password \
--name mongodb \
--network mongo-network \
mongo

3. 
docker run -d \
-p 8081:8081 \
-e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
-e ME_CONFIG_MONGODB_ADMINPASSWORD=password \
--network mongo-network \
--name mongo-express \
-e ME_CONFIG_MONGODB_SERVER=mongodb \
mongo-express

For logs - docker logs <container id>
4. Connect Node Server with Mongo DB container  
- connect using protocol -> 'mongodb://admin:password@localhost:27017' 

- Do above commands using docker compose ->

docker run -p 27017:27017 \
-d \ 
-e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password \
--name mongodb \
--network mongo-network \
mongo

mongo-docker-compose.yaml

version: '3'
services:
    mongodb: 
        image: mongo
        ports:
            - 27017:271017
        environment:
            - MONGO_INITDB_ROOT_USERNAME=admin 
            - MONGO_INITDB_ROOT_PASSWORD=password
        volumes:
            - mongo-data:/data/db              (host:inside container)
    mongo-express:
        image: mongo-express
        ports:
            - 8080:8080
        environment:
            - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
            - ME_CONFIG_MONGODB_ADMINPASSWORD=password
            - ME_CONFIG_MONGODB_SERVER=mongodb
volumes:
    mongo-data:             (named reference)
        driver: local       (create storage path on local file system)

Vol example diff for diff database - 
mysql:var/lib/mysql
postgres:var/lib/postgresql/data



docker compose takes care of creating a common network. 

To run docker compose file ->
docker-compose -f mongo.yaml up    (start all containers in yaml file)

stop containers 
docker-compose -f mango.yaml down 


- Build docker image from JS script (deploy application in its own docker container)
    - Jenkins builds application into docker image using Dockerfile & push to Docker Repo
    - Dockerfile
        - build docker image from app
        - copy artifact (jar,war, bundle.js) into Docker Image
        - blueprint for building image 
    - Ex.

    Image Environment blueprint

    install node
    set MONGO_DB_USERNAME=admin 
    set MONGO_DB_PWD=password 

    create /home/app folder

    copy current folder files to /home/app

    start the app with: node server.js

    
    Dockerfile
    FROM node:13-alpine    (Start from image that you base on)
    
    ENV MONGO_DB_USERNAME=admin 
    \ MONGO_DB_PWD=password             (Env variables)
    
    RUN mkdir -p /home/app            (RUN - execute any linux command)

    COPY ./app /home/app       (executes on host, from host source to container image target)
                           (RUN cp source dest  -> this command runs inside docker container)

    CMD ["node","/home/app/server.js"]    (execute entry point linux command)
                                (CMD entry point command and only one command vs RUN can be multiple commands)

    - Create Dockerfile as part of application code. save as -> Dockerfile
    app:1.0    <-   node:13-alpine   <-   alpine:3.10

    - Build Docker Image from Dockerfile  (this is what Jenkins does)
    docker build -t my-app:1.0 .   (second - location for docker image)

    docker images -> get image id

    - App including Dockerfile is commited to Git
    - Jenkins builds image from that Dockerfile and push to docker repo
    - Tester donwload image and test locally or Dev server pull it from there
    - docker run my-app:1.0 
    - when adjust dockerfile, rebuild image again
    - docker stop <containerid>
    - docker rm <containerid>   (delete container) 
    - docker rmi <imagetag>     (delete image)
    - docker exec -it <containerid> /bin/bash   (/bin/sh)
    - env    (to check environment variables)
    - ls /home/app/

    - generally compress folder into artifact and save to docker image 
    - can start with docker compose all containers at one go

- Private Repository of Docker Images (AWS ECR)
    - 1. Create private repo with docker - docker registry
        - in AWS
        - Elastic Container Registry
        - create repo - repo per image (save diff tags or versions of same image)
        - push my-app image to repo
        - 1. you have to login to private repo = docker login
        - docker login (aws ecr get-login --no-include-email --region eu-central-1)
        - docker build -t my-app .   (build image locally done prev)
        - docker tag my-app:1.0 5206.dkr.ecr.eu-central-1.amazonaws.com/my-app:1.0  (tell docker that image push to aws so tag image - rename to include repo domain or address, docker tag = rename image)
            - Image naming in docker repo
            - registryDomain/imageName:tag (can have short hand)
            - docker pull mango:4.2 <-> docker pull docker.ip/library/mongo:4.2
            - docker pull 5206.dkr.ecr.eu-central-1.amazonaws.com/my-app:1.0(AWS ECR)
        - docker push 5206.dkr.ecr.eu-central-1.amazonaws.com/my-app:1.0
    - make change to app, rebuild and push new version to AWS repo
        - docker build -y my-app:1.1 .   (. -> path to docker file)
        - docker tag my-app:1.1 5206.dkr.ecr.eu-central-1.amazonaws.com/my-app:1.1
        - docker push 5206.dkr.ecr.eu-central-1.amazonaws.com/my-app:1.1
        - 1 repo for 1 image includes diff versions 
    - test with diff versions - store them in repo (keep 1000 diff tags of same image)
    - Ex. Jenkins do automatically above commands -> Jenkins needs to login to your private docker repo
- Deploy application built from image in private repo in Dev Server
    - Run image in Dev Server 
        - my-app image pulled from private repo
        - mongo images pulled from public docker hub
    - start app on dev server need all containers that make that app env
    - The server needs to login to pull from PRIVATE repo
    - mongo.yaml 
        version: '3'
        services:
            my-app:
                image: 5206.dkr.ecr.eu-central-1.amazonaws.com/my-app:1.0
                ports: 3000:3000
            mongodb:
                image: mongo
                ports:
                    - 27017:27017
                environment:
                    - MONGO_INITDB_ROOT_USERNAME=admin
                    - MONGO_INITDB_ROOT_PASSWORD=password
            mongo-express:
                image: mongo-express
                ports:
                    - 8081:8081
                environment:
                    - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
                    - ME_CONFIG_MONGODB_ADMINPASSWORD=password
                    - ME_CONFIG_MONGODB_SERVER=mongodb
    - The docker-compose file above would be used on server to deploy all apps/services
    - 1. docker login (aws ecr login command above)
    - 2. docker compose file available on dev server
        vim mongo.yaml 
    - 3. docker-compose -f mongo.yaml up
- Complete workflow
    - Develop JS app locally with docker containers
    - Then we built this app into Docker image (like CI would do)
    - We pushed image into private repo
    - Finally we pulled our image from private repo
    

















    
















