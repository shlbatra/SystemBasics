- open source container orhestration tool 
- manage containers ex docker
- manage containerized apps in diff deployment envs - Physical, VM or cloud or hybrid
- trend from monolith to microservices - inc usage of containers
- demand for proper way of managing those hundeds of containers
- high availability or no downtime
- scalability or high performance (load fast with high response rate)
- disaster recovery - backup and restore
- kuberenetes basic architecture
- 1 master and multiple worker nodes, each node has kubelet process running on it
- kubelet makes it possible for cluster to talk to each other and execute tasks 
- each worker node docker containers of diff apps deployed on it
- worker nodes are where apps are running , much bigger and more resources
- master nodes run important kuberetes processes to manage cluster
- Ex. API Server - container that is entrypoint to K8S cluster (UI/API/CLI talk via API server)
- Controller Manager - keeps track of whats happening in cluster
- Scheduler - scheduling containers on diff nodes based on workload and available server resources, ensure pod placement
- etcd - key value storage, current state of kubernetes cluster, kubernetes backing store 
- virtual network -> enables worker and master nodes to talk,turns all nodes inside cluster into 1 powerful machine that has sum of all resources of individual nodes
- master -> imp node so in prod have 2 master nodes (1 backup)
- pods  -> smallest unit configure and interact , wrapper of container, each worker node has multiple pods, inside pod have multiple containers - 1 app per pod 
- container 
- virtual network assigns each pod its IP address so each pod its own self container server, communicate using internal IP address, 
- pod manages containers running inside itself without intervention
- pods ephemeral component - can die frequently and when die, new ones are created and gets new IP address
- Service substitute of dyanmic IP address that talk to each other
    - ip address permanent
    - load balancer 
- kubernetes configuration
- config request goes through master node with process called API server
- config request in YAML / JSON format -> Declarative form (decalre desired output)
- Deployment = template for creating pods

- Kubernetes Components
- Ex. Javascript app with DB backend 
- Node and Pod
- Pod
    - Smallest unit of K8s
    - Abstraction over container (Running env on top of container)
    - Interact with Kuberentes layer
    - app pod interact with db pod
    - Usually 1 application per pod 
    - Offers Virtual network - each pod gets it own IP address to communicate
    - pod components epheremeral - die easily, new one created get new IP address
    - Service used instead
- Service
    - permanent IP address attached to each pod
    - lifecycle of pod and service NOT connected
    - App should be accessible through browser - external service (open comm to external sources)
     - database -> internal service - not communicate to external sources
     - URL ext service - node ip address:port -> map to better name using Ingress
     - Request go to Ingress and then forwarded to Service
     - Ingress routes traffic into cluster
     - load balancer -> catch request and forward to pod that is less busy
- ConfigMap and Secret
     - my-app container talk to DB using mongo-db-service
     - Usually database url in built app. This requires re-build, push to repo and pull in your pod. 
     - configure database service in ConfigMap -> external config of your app
     - Ex. DB_URL = mongo-db-service
     - ConfigMap connect to pod so adjust here only and no need to rebuild image
     - Credentials put in Secret -> used to store secret data. stored in base64 encoded format. Ex. DB_USER=mongo-user , DB_PWD=mongo-pwd; connect SECRET to pod
     - Use Secret or ConfigMap as environmental variables or properties file
- Volumes
     - Data Storage
     - Database container / pod restarted then data gone - need it to be persisted
     - Attaches physical storage on harddrive to pod. Can be on local machine or remote - outside K8s cluster ex. Cloud storage
     - K8s doesnt manage data persistence
- Deployment and Stateful Set
     - User access app through browser 
     - if my-app container/pod die then lead to downtime so distributed system
     - replicate everything on multiple servers, The replica connected to service as well
     - create replica - define blueprint for pods and specify replica you need 
     - provide in Deployment: (blueprint for my-app pods and you create Deployments)
     - pod abstraction on top of containers
     - Deployment abstraction on top of pods
     - Database pod -> 
        - database replicate not via deployment - as they have state, all access same shared data storage - need mechanism for pod read/write
        - So use StatefulSet for stateful apps - ex. elasticsearch, mongodb, mysql
        - deployment for stateLESS apps
        - statefulset for stateFUL apps or database
        - deploying statefulset not easy so prefer host database outside of k8s cluster, with replica - service more load balanced, 
- K8s Architecture
    - Node Processes with 2 app pods running on it
    - each node has multiple pods on it 
    - 3 processes must be installed on every node
        - container runtime
        - kubelet -> schedules pod run, interacts with both - container and node
        - kubelet takes config, start pod with container inside and assign resources
        - communication between nodes via services
        - kubeproxy -> forward requests from services to pods, does intelligent avoiding overhead
    - worker nodes do actually work
    - how interact with cluster ?
        - schedule pod ?
        - monitor pods ?
        - reschedule or restart pods ?
        - server join as new node ?
        - all processes above done by master node (4 processes)
            - API server -> client interact with API server - cluster gateway
            - acts as gatekeeper for authentication
            - any request talk to API server - validate request forward to other processes to schedule pod, only 1 entrypoint to cluster
            - Scheduler -> ex. schedule new pod, inteligent way on which worker node next pod scheduled based on resources requsted, just decides on which node new pod should be scheduled; Kubelet -> starts the pod at node
            - Controller Manager -> detect pods die and reschedule them, detect cluster state changes and recover cluster state by requesting to scheduler
            - etcd -> key value store of cluster state, cluster brain, every change of cluster stored in key value store, data used by scheduler for resources available or used by contoller manager for state change or cluster health by api server , doesnt store any application data ex database app. 
        - cluster made of multiple master nodes , API server load balanced and etcd is ditributed storage across all master nodes, 
    - Example Cluster Setup
        - 2 Master and 3 worker nodes -> master need less resources than worker nodes
        - add new master/node server 
            - get new bare server
            - install all master/worker node processes
            - add to cluster
- MiniKube
    - Cluster -> test on local machine ?
    - One node cluster where master and worker processes run on same machine with docker pre-installed. Run via Virtual Box or Hypervisor. Node runs in Virtual Box as 1 Node K8s cluster
    - Minikube requires virtualization on your machine, Install hypervisor
    - Interact with cluster by minikube using kubectl 
    - kubectl - Command Line tool for K8s cluster
    - Master processes enable interaction with cluster via API server 
    - talk via UI/Kubernetes API / CLI -> kubectl (most powerful)
    - Work processes execute the commands such as create pods , create services or destroy pods
    - Work with any type of cluster - Cloud Cluster
    -   brew update
        brew install hyperkit
        brew install minikube (kubectl depedency)
        kubectl
        minikube start --vm-driver=hyperkit  (start cluster and provide hypervisor to use)
        kubectl get nodes (status of nodes)
        minikube status   (status of minikube)
        kubectl version 
- Main Kubectl commands 
    - kubectl get nodes 
    - kubectl get pod
    - kubectl get services
    - kubectl create -h (pod smallest unit but you create deployment - abstraction over pods)
    - kubectl create deployment nginx-depl --image=nginx (nginx deployment)
        - bludeprint for creating pods
        - most basic config for deployment (name and image to use)
        - rest defaults
    - kubectl get depoyment 
    - kubectl get pod
    - kubectl get replicaset  (automatically created layer between pod and deployment) -> manage replicas of pod via deployment 
    - Layers of Abstraction
        - Deployment manages a 
        - Replicaset manages a
        - Pod is an abstraction of
        - Containers
        Everything below deployment handled by Kubernetes
    - kubectl edit deployment nginx-depl  (get auto generated file with default values)  -> change image version or anything you want 
    - kubectl get pod (old pod terminating and new one starting)
    - kubectl get replicaset (old have no pods and new one has 1 pod in it)
    - kubectl logs <podname>  (debugging pods)
    - kubectl describe pod <podname> (shows state change in pod)
    - kubectl exec <podname> -- bin/bash   (gets terminal of mongodb app terminal - container terminal)
    - kubectl delete deployment <deploymentname> (this deletes relevant pod and replicateset as well)
    - better way to create deployment using configuration file -> provide name and component and image in 1 config file - kubectl execute config file
    - kubectl apply -f <filename>   (takes config file in yaml format and does whatever written there)
    - kubectl delete -f <filename>    (delete with config file)
    - nginx-deployment.yaml 
        apiVersion: apps/v1
        kind: Deployment
        metadata:
            name: nginx-deployment
            labels:
                app: nginx
            spec:    (for deployment)
                replicas: 1
                selector:
                    matchLabels:
                        app: nginx
                template:
                    metadata:
                        labels:
                            app: nginx
                    spec:    (for pod)
                        containers:
                            - name: nginx
                              image: nginx:1.16
                              ports:
                              - containerPort: 80
        - change file using vim nginx-deployment.yaml 
        - apply again using kubectl apply -f nginx-deployment.yaml (K8s knows when to create or update deployment)
        - kubectl get nodes | pod | services | replicaset | deployment
- K8s YAML Configuration File
    - Create and configure components in Kubernetes Cluster
    - Connect deployment to service to pods (3 Parts)
    - 3 parts
        - metadata (name, specification, what create - deployment, service, etc)
        - specification -> attribute specific to kind (deployment or service)
        - status -> automatically generated and added by kubernetes, check desired and actual state based on spec and fix accordingly. Self healing nature of kubernetes, kubernetes update state continously based on specification,
            - where get status data -> etcd key value store, current status of any kubernetes component 
    - YAML format -> strict indentation (yaml online validator), human friendly data serialization standard for all programming issue. store config file with your code. part of Infra as Code conde
    - Blueprint for pods
        - deployment manage Pods
        - spec:
                kind: Deployment
                metadata:
                name: nginx-deployment
                labels:
                    app: nginx
                spec:
                    replicas: 2
                    selector:
                        matchLabels:
                            app: nginx
                template:   <- applies to pod (blueprint for pod - port, image, name)
                    metadata:
                        labels:
                            app: nginx 
                    spec: 
                        containers:
                        - name: nginx
                        image: nginx:1.16
                        ports:
                        - containerPort: 8080
        - connecting components (labels and selectors and ports)
            - labels and selectors
                key value pair give to component. Ex deployment above is app -> nginx
                pods get label through template blueprint
                label is matched by selector (both in deployment and service as well)
            - ports in service and pod
                nginx service
                ports:
                - protocol: TCP
                  port: 80
                  targetPort: 8080
                DB Service  port:80-> nginx Service targetPort:8080-> Pod (match containerPort)  
            - Full Example

            nginx-deployment.yaml
            
            apiVersion: apps/v1
            kind: Deployment
            metadata:
            name: nginx-deployment
            labels:
                app: nginx
            spec:
            replicas: 2
            selector:
                matchLabels:
                app: nginx
            template:
                metadata:
                labels:
                    app: nginx
                spec:
                containers:
                - name: nginx
                    image: nginx:1.16
                    ports:
                    - containerPort: 8080

            nginx-service.yaml

            apiVersion: v1
            kind: Service
            metadata:
            name: nginx-service
            spec:
            selector:
                app: nginx
            ports:
                - protocol: TCP
                port: 80
                targetPort: 8080

        - run these now -
            kubectl apply -f nginx-deployment.yaml 
            kubectl apply -f nginx-service.yaml

            validate service has right port that it forwards request to right pod
            kubectl describe service nginx-service  -> check endpoints - IP address for ports where service address forward to 
            kubectl get pod -o wide  (more info - confirm IP) 

        - Status automatically generated - get updated config file in etcd with status
          kubectl get deployment nginx-deploymnet -o yaml > nginx-deploy-res.yaml

        - copy deployment already have - need to remove generated stuff and then create another deployment 
        - delete deployment using config file
        kubectl delete -f nginx-deployment.yaml 
        kubectl delete -f nginx-service.yaml 

- Complete Application Setup with Kubernetes Components
    - mongodb (Request to db)
    - mongo-express (Web app)

    Internal Service    ConfigMap (DB Url)      Deployment.yaml (env var)
        MongoDB                                   Mongo-Express    External Service
                            Secret (DB User and DB Pwd)     
        Ext Service   URL:
                      - IP address of node
                      - Port of external service 

    kubectl get all    #minikube running 
    
    create mongodb deployment 
        mongo.yaml -> 

        apiVersion: apps/v1
        kind: Deployment
        metadata:
        name: mongodb-deployment
        labels:
            app: mongodb
        spec:
        replicas: 1
        selector:
            matchLabels:
            app: mongodb
        template:
            metadata:
            labels:
                app: mongodb
            spec:
            containers:
            - name: mongodb
                image: mongo
                ports:
                - containerPort: 27017
                env:
                - name: MONGO_INITDB_ROOT_USERNAME
                valueFrom:
                    secretKeyRef:
                    name: mongodb-secret
                    key: mongo-root-username
                - name: MONGO_INITDB_ROOT_PASSWORD
                valueFrom: 
                    secretKeyRef:
                    name: mongodb-secret
                    key: mongo-root-password
        ---            (Doc seperation in yaml - deployment and service in same file)
        apiVersion: v1
        kind: Service
        metadata:
        name: mongodb-service
        spec:
        selector:
            app: mongodb    (connect to pod through label)
        ports:
            - protocol: TCP
            port: 27017          (service port)
            targetPort: 27017    (container port of deployment)

    Secret lives in kubernetes and not github :
        mongo-secret.yaml
        
        apiVersion: v1
        kind: Secret
        metadata:
            name: mongodb-secret
        type: Opaque
        data:
            mongo-root-username: dXNlcm5hbWU=   (value base 64 encoded)
            mongo-root-password: cGFzc3dvcmQ=

        #how create a secret user name and password
        echo -n 'username' | base 64 -> dXNlcm5hbWU=

        # commands to get mongo db deployment up and running 

        cd k8s-configuration 
        kubectl apply -f mongo-secret.yaml (do before deployment  as reqd)
        kubectl get secret   (reference inside deployment now)
        then create deployment 
        kubectl apply -f mongo.yaml
        kuetctl get all 
        kubectl get pod --watch 
        kubectl describe pod <podname>
        kubectl get service
        kubectl describe service <servicename>  #match endpoint ip for port
        kubectl get pod -o wide  
        kubectl get all | grep mongodb

        Create deployment for mongo-express.yaml 
        mongo-express.yaml

        apiVersion: apps/v1
        kind: Deployment
        metadata:
        name: mongo-express
        labels:
            app: mongo-express
        spec:
        replicas: 1
        selector:
            matchLabels:
            app: mongo-express
        template:
            metadata:
            labels:
                app: mongo-express
            spec:
            containers:
            - name: mongo-express
                image: mongo-express
                ports:
                - containerPort: 8081
                env:
                - name: ME_CONFIG_MONGODB_ADMINUSERNAME      (credentials)
                valueFrom:
                    secretKeyRef:
                    name: mongodb-secret
                    key: mongo-root-username
                - name: ME_CONFIG_MONGODB_ADMINPASSWORD
                valueFrom: 
                    secretKeyRef:
                    name: mongodb-secret
                    key: mongo-root-password
                - name: ME_CONFIG_MONGODB_SERVER  (Mongodb address/internal service)
                valueFrom: 
                    configMapKeyRef: (#ext config,centralized,other component use it)
                    name: mongodb-configmap
                    key: database_url
        ---
        apiVersion: v1       (#External Service to connect via browser)
        kind: Service
        metadata:
        name: mongo-express-service
        spec:
        selector:
            app: mongo-express
        type: LoadBalancer       (#Makes this service as Ext Service)
        ports:
            - protocol: TCP
            port: 8081
            targetPort: 8081
            nodePort: 30000   (#Makes this service as Ext Service - port where Ext IP address open - put in browser, can be in range 30000-32767)

        Loadbalancer - assigns service an external IP address and so accepts external requets. 

        Create ConfigMap below -
        mongo-configmap.yaml

        apiVersion: v1
        kind: ConfigMap
        metadata:
            name: mongodb-configmap
        data:
            database_url: mongodb-service
        #create this first before mongo-express is created

        kubectl apply -f mongo-configmap.yaml
        kubectl apply -f mongo-express.yaml
        kubectl get pod
        kubectl logs <podname>
        kubectl get service   


        ClusterIP gives internal IP address whereas LoadBalancer give Int IP address and Ext IP address plus ports for both int/ext ip address.
        minikube service <servicename>    #assigns ext IP address to ext service 

        Browser request -> Mongo Express External Service -> Mongo Express Pod -> Mongo DB Internal Service -> Mongo DB Pod

- Kubernetes Namespace Explained
    - Organize resources in namespace
    - virtual cluster inside a cluster
    - 4 namespaces by default
        - kubernetes-dashboard -> only with minikube
        - kube-system -> do not create/modify, system processes - master and kubectl processes deployed in this namespace
        - kube-public -> publicly accessible data, configmap that contains cluster information
            kubectl cluster-info
        - kube-node-lease -> heartbeats of nodes, each node has assosciated lease object in namespace, determine availability of node
        - default -> resources you created are located here if not define custom namespace
    - kubectl get namespace
    - kubectl create namespace my-namespace
    - create namespace with config file
        Ex.
        apiVersion: v1
        kind: ConfigMap
        metadata:
            name: mysql-configmap
            namespace: my-namespace
        data:
            db_url: mysql-service.database
    - Why need namespace ?
        - everything in one namespace -> default namespace filled with diff components so resources grouped in namespace
            - database with all its resources - namespace1
            - monitoring with all its resources - namespace2
            - elastic stack with all its resources - namespace3
            - nginx-ingress with all its resources - namespace4
        - Many teams work on same application 
            - 2 teams - same name but diff config - override deployments - not know if use jenkins (automated tool) -> namespace seperate without disrupting other
        - Host staging and development in 1 cluster -> allows for resource sharing/reuse components ex. nginx-ingress controller / elastic stack
        - blue green deployment - Same cluster 2 prod env. - versions of application will differ but reuse components ex. nginx-ingress controller / elastic stack
        - Access and resource limits on namespaces -> 2 teams on same cluster, each team has namespace -> access to only namespace (create/delete resources), each team has own isolated env., Limit resources - cpu/ram/storage per NS; define resource quotas per namespace
    - Characterstics of Namespace
        - cannot access resources from another namespace. Ex. N1 -> configmap to db not use same configmap for N2 - need its own configmap, Secret
        - Access service in another namespace,
        Ex. N1-database-configmap.yaml
            apiVersion: v1
            kind: ConfigMap
            metadata:
                name: mysql-configmap
            data:
                db_url: mysql-service.database   (name.namespace - access service from other namespace)
        - Components which cant be created within namespace -> live globally in cluster and you cant isolate them, you Ex. persistent volume or node
            kubectl api-resources --namespaced=false  (list components not bound by namespace)
            kubectl api-resources --namespaced=false (components bound by namespace)
        - Create component in namespace - By default, components are created in default NS
            Ex. Create namespace for configmap in my-namespace 
            kubectl apply -f mysql-configmap.yaml --namespace=my-namespace
            Ex. Inside config file itself - better way (documented, more convenient for automated deployment)
            apiVersion: v1
            kind: ConfigMap
            metadata:
                name: mysql-configmap
                namepsace: my-namespace
            data:
                db_url: mysql-service.database
            To look for this namespace, 
                kubectl get configmap -n my-namespace
        - Change active namespace so not put kubectl get configmap -n my-namespace
            - change active namespace with kubens 
            - brew install kubectx     (install kubens)
            - kubens   (all namespace with active one)
            - kubens my-namespace    (change active namespace)
- K8s ingress explained 
    - External Service 
        - my-app pod     my-app service(ext)     browser -> http://my-app-service-ip:port
        - Access via external service ; http://124.89.101.2:35010 (IP for node)
        - Good for test cases
        - Ex. YAML file

            apiVersion: v1
            kind: Service
            metadata:
                name: myapp-external-service
            spec:
                selector:
                    app: myapp
                type: LoadBalancer
                ports:
                    - protocol: TCP
                      port: 8080
                      targetPort: 8080
                      nodePort: 35010   (Ext Port Number with Ext IP address)

    - Ingress
        - better way ingress 
        - my-app pod  my-app service(int)  my-app ingress  browser->http://my-app.com
        - service IP address and port not opened
        - Ex Ingress YAML -> 
            apiVersion: networking.k8s.io/v1beta1
            kind: Ingress
            metadata:
                name: myapp-ingress
            spec:
                rules:
                - host: myapp.com
                  http:    (Incoming request gets forwarded to internal service)
                    paths:               (URL path. Ex myapp.com/path?)
                    - backend:
                        serviceName: myapp-internal-service
                        serviceport: 8080

        Routing rules: Forward request from myapp.com to internal service myapp-internal-service:8080
        myapp.com -> Valid domain name
                  -> map domain name to Node IP address which is entrypoint. 

        Internal Service YAML for above defined ingress service ->
            apiVersion: v1
            kind: Service
            metadata: 
                name: myapp-internal-service
            spec:
                selector:
                    app: myapp
                ports:
                    - protocol: TCP
                      port: 8080
                      targetPort: 8080

    - How configure ingress in your cluster ?
        - need implementation for ingress in addition to ingress component yaml defined above
        - install Ingress Controller (set of pods in cluster -> evaluate and process ingress rules, manage all redirections, entrypoint to cluster, identify forwarding rule apply for that request, decide between many third party apps)
        - Ex. K8s Nginx Controller
    - my-app pod <- my-app service (int) <- my-app ingress <- pod (ingress controller pod)
    - Environment on which cluster runs ?
        - Cloud Service Provider - out of box K8s solutions or virtualized load balancer 
        Cloud Load Balancer -> Ingress Controller Pod
        - Bare Metal : Configure some kind of entrypoint , Do inside of cluster or outside as seperate server Ex. External Proxy Server - Software or hardware solution  (seperate server, public IP address and open ports, entrypoint to cluster) -> Ingress Controller checks Ingress rules forward to Int Service
    - Configure Ingress in Minikube
    my-app pod <- my-app service (int) <- my-app ingress <- pod (ingress controller pod)
    - Install ingress controller in minikube 
        - minikube addons enable ingress (Automatically start K8s Nginx implementation of ingress controller)
        - kubectl get pod -n kube-system    (check for controller)
    - Create ingress rule that controller can evaluate 
        - kubernetes-dashboard (namespace not accessible externally, internal service and pod exists, configure ingress rule to access using domain name )
        - kubernetes get all -n kubernetes-dashboard (see components of kuberentes dashboard - check int service and pod)
        - dashboard-ingress.yaml  (ingress for forwarding request to int service)
            apiVersion: networking.k8s.ip/v1beta1
            kind: Ingress
            metadata:
                name: dashboard-ingress
                namespace: kubernetes-dashboard
            spec:
                rules:
                - host: dashboard.com    (Resolve IP address to host name)
                  http: 
                    paths:
                      - backend:
                            serviceName: kubernetes-dashboard
                            servicePort: 80 

        kubectl apply -f dashboard-ingress.yaml 
        kubectl get ingress -n kubernetes-dashboard 

        sudo vim /etc/host   (Resolve IP address to host name)
        <ip address for ingress>   dashboard.com    (Request go to ingress controller then ingress internal service)
    - Ingress Default Backend 
        - kubectl describe dashboard-ingress -n kubernetes-dashboard
        - default-hhto-backend:80 (if request not map to any rule then default backend use for it. So, need to create this component- custom error messages)
        - default-backend.yaml
            apiVersion: v1
            kind: Service
            metadata:
                name: default-http-backend
            spec:
                selector:
                    app: default-response-app
                ports:
                    - protocol: TCP
                      port: 80
                      targetPort: 8080
    - Multiple paths for same host 
        - Example google -> one domain but many services (gmail, calendar)
          define 1 host with multiple paths here 
        http://myapp-com/analytics -> analytics service(int) -> analytics pod
        http://myapp-com/shopping -> shopping service(int) -> shopping pod

        Ex YAML file below ->
        apiVersion: networking.k8s.io/v1beta1
        kind: Ingress
        metadata:
            name: simple-fanout-example
            annotations:
                nginx.ingress.kubernetes.io/rewrite-target: /
        spec:
            rules:
            - host: myapp.com
              http:
                paths:
                - path: /analytics
                  backend:
                    serviceName: analytics-service
                    servicePort: 3000
                - path: /shopping
                  backend:
                    serviceName: shopping-service
                    servicePort: 8080

    - Multiple subdomains or domains 
        - Instead of 1 host and multiple path, you have multiple hosts with 1 path. Each host represents a subdomain
        Ex YAML file below ->
        
        apiVersion: networking.k8s.io/v1beta1
        kind: Ingress
        metadata:
            name: simple-virtual-host-ingress
        spec:
            rules:
            - host: analytics.myapp.com
              http:
                paths:
                  backend:
                    serviceName: analytics-service
                    servicePort: 3000
            - host: shopping.myapp.com 
              http:       
                paths:
                  backend:
                    serviceName: shopping-service
                    servicePort: 8080
        http:analytics.myapp.com -> analytics service(int) -> analytics pod

    - Configuring TLS Certificate (https forwarding in ingress)
        - define attribute tls and secretName (create in cluster tls cert and tls key)
        - Ex. secret.yaml
            apiVersion: v1
            kind: Secret
            metadata:
                name: myapp-secret-tls
                namespace: default
            data:
                tls.crt: base64 encoded cert
                tls.key: base65 encoded key
            type: kubernetes.io/tls

        Ingress.yaml file change (add tls)
            apiVersion: networking.k8s.io/v1beta1
            kind: Ingress
            metadata:
                name: tls-example-ingress
            spec:
                tls:
                - hosts:
                    - myapp.com
                    secreteName: myapp-secret-tls
                rules:
                    - host: myapp.com
                      http:
                        paths:
                            - path: /
                                backend:
                                    serviceName: myapp-internal-service
                                    servicePort: 8080

            Things to keep in mind for tls in secret file :
            1. Data keys need to be "tls.crt" and "tls.key"
            2. Value are file contents and not file paths/locations
            3. secret component in same namespace as Ingress component

- HELM - Package Manager of K8s
    - Package Manager for kubernetes, similar to spt/homebrew
    - package YAML files and distribute them in public and private repos
    - deploy ELASTIC Stack for Logging in k8s cluster so need 
        - Stateful Set for stateful apps
        - ConfigMap for external config 
        - Secret for secret data 
        - K8s user with persmissions
        - Services
    - 1. create all yaml file manually and deploy. 
    - 2. since its standard, create yaml files once and package at one place so everyone can use it in their k8s deployment 
        - bundle of yaml files called helm charts, 
        - create own helm chart with helm, 
        - push to help repo, 
        - download and use existing helm charts 
    - Ex. helm charts
        - Database Apps - ElasticSearch, mongoDB, MYSQL
        - Monitoring Apps - Promotheus 
    - helm install <helmchartname>
    - Sharing helm charts 
        - need some deployment 
            - look in helm (helm search <keyword>)
            - look in helm hub
        - public repo
        - private repo (share in organizations)
    - Templating engine
        - App made of multiple microservices deploying on k8s cluster
        - Use fo CI/CD - In build you can replace values on fly
        - deployment and service config similar , diff - image and version tag diff
        - 1. multiple deployment service files with app name and version
        - 2. with help, define common blueprint, dyanmic values replaced by placeholders
            - Template YAML config
                apiVersion: v1
                kind: Pod
                metadata:
                    name: {{.Values.name}}
                spec:
                    containers:
                    - name: {{.Values.container.name}}
                      image: {{.Values.container.image}}
                      port: {{.Values.container.port}}
            {{.Values}} -> Object created based on values defined
              values.yaml  provides {{.Values}}   or use --set flag
                name: my-app
                container:
                    name: my-app-container
                    image: my-app-image
                    port: 9001

    - Same Apps deploy across diff envs (k8s cluster)
        - deploy microservices on Dev, Staging and Prod cluster
        - Instead of multiple yaml files on each cluster, package into own chart 
        - use chart redeploy same app in diff clusters 

    - Helm Chart Structure
        - directory structure
        mychart/             Top level mychart folder - name of chart
            chart.yaml       meta about chart ex. name, version, depedencies
            values.yaml      values for template files - default that override
            charts/          chart depedencies     
            templates/       actual template files 
            ...  (Readme or license files)
        help install <chartname>  -> template files will be filled with values from values.yaml producing k8s manifest deployed on k8s 

        Ex.
        values.yaml 
        imageName: myapp
        port: 8080
        version: 1.0.0

        default 

        Override by helm install --values=my-values.yaml <chartname>
        my-values.yaml
        version: 2.0.0

        result  .Values object
        imageName: myapp
        port: 8080
        version: 2.0.0

        Alternate way using set flag
        helm install --set version=2.0.0

    - Release Management 
        - Helm version 2
        2 parts 
        CLIENT(helm CLI) -> Send request to Tiller   K8s cluster (SERVER(Tiller))
        Change config then tiller store copy of configuration -> history of chart execution
        help install <chartname>
        helm update <chartname>  #changes to existing deployment and not new one
        help rollback <chartname>  #go back to previos deployment / request 

        Tiller 
        - Too much inside K8s cluster - create, update and delete
        - Security issue 
        - Heml version 3 -> no server (tiller) , just helm binary

- K8s Volume Explained (Persist Data)
    - Persistant Volume 
    - Need for Volumes ?
        - mysql pod (data created / updated) - restart pod - all changes gone as no data persistence in k8s -> need to configure that
        - Storage not depend on pod lifecycle and available on all nodes as not know where pod restart and highly available storage that survice if cluster crashes
        - directory (app read/write directory. Ex session files for app or config files)
    - Persistent Vol
        - cluster resource to store data
        - created via YAML file
        - need actual physical storage ex. local disk, nfs server or cloud storage
        - Who makes storage available to cluster ?
            - k8s provides as interface storage that you have to take care of 
            - you need to create and manage storage by yourself(backup/corrupt)
            - external plugin to cluster -> local or remote storage
            - multiple storage configured on same cluster
        - Ex. NFS Storage configured 
        apiVersion: v1
        kind: PersistentVolume
        metadata:
        name: pv-name
        spec:
        capacity:
            storage: 5Gi
        volumeMode: Filesystem
        accessModes:
            - ReadWriteOnce
        persistentVolumeReclaimPolicy: Recycle
        storageClassName: slow
        mountOptions:
            - hard
            - nfsvers=4.0
        nfs:
            path: /dir/path/on/nfs/server
            server: nfs-server-ip-address
    
    - Ex. Google Cloud Storage
    apiVersion: v1
    kind: PersistentVolume
    metadata:
    name: test-volume
    labels:
        failure-domain.beta.kubernetes.io/zone: us-central1-a__us-central1-b
    spec:
        capacity:
            storage: 400Gi
        accessModes:
            - ReadWriteOnce
        gcePersistentDisk:
            pdName: my-data-disk
            fsType: ext4

    - Ex. Local Storage (needs a node affinity attribute as well)
        apiVersion: v1
        kind: PersistentVolume
        metadata:
        name: example-pv
        spec:
        capacity:
            storage: 100Gi
        volumeMode: Filesystem
        accessModes:
        - ReadWriteOnce
        persistentVolumeReclaimPolicy: Delete
        storageClassName: local-storage
        local:
            path: /mnt/disks/ssd1
        nodeAffinity:
            required:
            nodeSelectorTerms:
            - matchExpressions:
                - key: kubernetes.io/hostname
                operator: In
                values:
                - example-node

    - Persistent Vol not namespaced - accessible to whole cluster
    - Local vs Remote Vol Types
    - Local violate 2 and 3 reqt for data persistence 
        - not tied to 1 node but all nodes
        - not survive in cluster crashes
    - Remote -> Most preferables for DB persistence 
    - Who create PV and when ?
        - resources need to be BEFORE pod that depends on it is created
    - Roles in K8s
        - K8s Admin
            - sets up and mantains cluster
            - check for enough resources ?
            - Storage resource is provisioned and configured
            - create PV components from these storage backends 
        - K8s User
            - deploys apps in cluster directly or CI pipelines
            - Configure app YAML file to use PV components
            - app claim persistent volume using Persistent Volume Claim
            - Persistent Volume Claim (PVC) created using YAML config, whatever PV matches the criteria in PVC will be used. Then PVC used in Pods Configuration
        - Pod requests volume through PVC -> Claim tries to find volume in cluster -> Volume has actual storage backend
        - Claims must be in same namespace as pod using namespace
        - once pod finds matching volumne, then Volume is mounted into pod and then into container (can be all containers in pod or just specific one - read/write to storage from container)
        - Ex. 
            persistent volume claim.yaml

            kind: PersistentVolumeClaim
            apiVersion: v1
            metadata:
            name: pvc-name
            spec:
            storageClassName: manual
            volumeMode: Filesystem
            accessModes:
                - ReadWriteOnce
            resources:
                requests:
                storage: 10Gi

            pod linked to pvc (yaml file)

            apiVersion: v1
            kind: Pod
            metadata:
            name: mypod
            spec:
            containers:
                - name: myfrontend
                image: nginx
                volumeMounts:
                - mountPath: "/var/www/html"
                    name: mypd
            volumes:
                - name: mypd
                persistentVolumeClaim:
                    claimName: pvc-name
            * apps can access mounted data here: "var/www/html"
    - Why so many abstractions ?
        - Admin provisions storage resource
        - User creates claim to PV
        - user not care about where actual storage is. cloud or local 
        - not care about set up actual storage yourself
    - 2 Volume types (local volumes, not created by PV and PVC, managed by K8s)
        - ConfigMap
        - Secret 
        - Ex. Config file for pod, Certificate file for pod
        1. Create ConfigMap / Secret component
        2. Mount that into your pod/container
        Ex. Pod YAML file
            apiVersion: v1
            kind: Pod
            metadata:
                name: mypod
            spec:
                containers:
                    - name: busybox-container
                      image: busybox
                      volumeMounts:
                        - name: config-dir
                          mountPath: /etc/config
                volumes:
                    - name: config-dir
                      configMap:
                        name: bb-configmap
    - Diff Vol Types in pod
        - Ex. elastic-app pod need configmap (config file), secret (client certificate), database storage (awselasticblockstore) 
        - in volumes, list all volumes that mount to pod
        - Ex. YAML file below

            apiVersion: apps/v1
            kind: Deployment
            metadata:
            name: elastic
            spec:
            selector:
                matchLabels:
                app: elastic
            template:
                metadata:
                labels:
                    app: elastic
                spec:
                containers:
                - image: elastic:latest
                    name: elastic-container
                    ports:
                    - containerPort: 9200
                    volumeMounts:
                    - name: es-persistent-storage
                    mountPath: /var/lib/data
                    - name: es-secret-dir
                    mountPath: /var/lib/secret
                    - name: es-config-dir
                    mountPath: /var/lib/config
                volumes:
                - name: es-persistent-storage
                    persistentVolumeClaim:
                    claimName: es-pv-claim
                - name: es-secret-dir
                    secret:
                    secretName: es-secret 
                - name: es-config-dir
                    configMap:
                    name: es-config-map

    - Storage Class 
        - Admins configure storage -> create PV -> K8s claim PV using PVC
        - Dev need create storage PV for users to use via PVC -> Admins claim storage manually from cloud providers & create PVs (time consuming)
        - 3rd K8s component
        - Storage Class
            - SC creates volumes dyanmically
            - when PVC claims it
            - automated process 
            - another abstraction level abstracts underlying storage provider
            - created using YAML file 
            - storagebackend defined in SC component using "provisioner" attribute, each has its own, internal provisioner- kubernetes.io
            for others, external provisioner. 
                apiVersion: storage.k8s.io/v1
                kind: StorageClass
                metadata:
                name: storage-class-name
                provisioner: kubernetes.io/aws-ebs
                parameters:
                    type: io1
                    iopsPerGB: "10"
                    fsType: ext4

            Storage class usage in PVC YAML -> 
                apiVersion: v1
                kind: PersistentVolumeClaim
                metadata:
                    name: mypvc
                spec:
                    accessModes:
                    - ReadWriteOnce
                    resources:
                    requests:
                        storage: 100Gi
                    storageClassName: storage-class-name
        1. Pod claims storage via PVC
        2. PVC requests storage from SC
        3. SC creates PV that meets the needs to the claim using provisioner

- K8s StatefulSet Explained
    - used for stateful apps 
    - Ex. database, app that stores data to keep track of state
    - stateless apps - dont keep record of state, each request is completely new based on new info coming to it
    - Ex.
    nodeJS            update      <->  query          mongodb
    stateless                                         stateful 
   doesnt depend on prev data               update/query data based on prev state
   passthrough for data query/update        depends on most up to data data/state
    - Deployment of Stateful and stateless apps
    - Stateless
        - using Deployment (abstraction of pods) , replicate your app on cluster
    - Stateful
        - using StatefulSet component, replicate pods, 
    - both 
        - manage pods based on container specification, 
        - configure storage same way
    - difference
        - replicating stateful more difficult
        - ex. MySQL pod(replica=3)            my-app (java,replica=3, stateless)
        - my-app 
            - identical and interchangeable, 
            - created in random order with random hashes, 
            - one service load balances to any pod, 
            - delete/scale down in random order
        - mySQL pod
            - cant be created/deleted at same time
            - cant be randomly addresses
            - replica Pods arent identical - Pod Identity
            - statefulset gives sticky identity for each pod
            - pod created from same specification but not interchangeable
            - persistent identifier across any re-scheduling, new pod keeps old identifty
            - Why identity necessary ?
                - scaling database apps
                - single mysql pod (read and write)
                - 2 pods (get data inconsistency) - mechanism to write from 1 pod(master) shared across, read from across all pods(slaves). 
                - pods not have access to same physical storage (replica of storage - continously sync, slave know about change from master so keep it updated - continous data sync)
                - new pod replica joins -> create own storage (clone data from prev pod, and then start continous sync)
                - temp storage theoretically possible as data gets replicated between pods but data will be lost when all pods die
                - best practice to use data persistence (data survive when pods die)
                - configure PV (persistent vol) for statefulset
                - pod has its own PV with its state (master or slave) - pod dies and replaced - persistent pod identifiers - storage vol reattached to new pod (use remote storage)
                - Pod Identity -> every pod has its identifier, fixed ordered names - $(statefulset name)-(ordinal) ex. mysql-0
                - first one master and rest are slaves for stateful set replicas
                - next pod is only created if prev is up and running
                - delete or scale down statefulset - start from last pod and move in reverse order
                - This allows to protect data and state
                - Each pod also gets its own DNS endpoint from service
                - loadbalancer service -> individual service name at statefulset
                - 1. predictable pod name    mysql-0
                - 2. fixed individual DNS name     mysql-0.svc2
                - When pod restarts -
                    - IP address changes
                    - name and endpoint stays same 
                - Sticky identifty - retain state and role 
                - Replicating stateful apps is complex. You need to ->  
                    - configure cloning and data sync in stateful set
                    - make remote storage available
                    - manage and back up
                - stateful apps not perfect for containerized apps. Good for stateless apps only. 

- K8s Services 
    - Each pod has its own ip address - but pods ephemeral (destroyed frequently)
    - pod restart then get new IP so need to adjust everytime
    - Service
        - stable IP address 
        - loadbalancing for pod replicas (each request target to one of pods)
        - loose coupling 
        - within and outside cluster 
    - ClusterIP Service
        - default type when type not specified
        - Ex. YAML File 
            apiVersion: v1
            kind: Service
            metadata:
                name: microservice-one-service
            spec:
                selector:
                    app: microservice-one
                ports:
                    - protocol: TCP
                      port: 3200
                      targetPort: 3000
        - microservice app deployed in pod   (port3000)
        - side car container collects microservice logs to db (port9000)
        - IP address from Node's range (internal in cluster)
        - ex. node 1 -> 10.2.1.x
              node 2 -> 10.2.2.x
              node 3 -> 10.2.3.x
        - Ex. Node IP - 10.2.2.5    ( kubectl get pod -o wide gives IP)
        - if replica 2 - then get another pod with diff ip address 10.2.1.4
        - access from browser via ingress (configured) -> request forwarded using Service (internal service) - ip address:port where service is accessible
        - ingress rules.yaml
            apiVersion: networking.k8s.io/v1beta1
            kind: Ingress
            metadata:
                name: ms-one-ingress
                annotations:
                    kubernetes.io/ingress.class: "nginx"
            spec:
                rules:
                    - host: microservice-one.com
                      http:
                        paths:
                            - path:
                                backend:
                                    serviceName: microservice-one-service
                                    servicePort: 3200

        - above ingress forward to service-clusterIP.yaml
            apiVersion: v1
            kind: Service
            metadata:
                name: microservice-one-service
            spec:
                selector:
                    app: microservice-one    #labels of pods (key value pair)
                ports:
                    - protocol: TCP
                      port: 3200
                      targetPort: 3000

        - service forward request to one of pods (replica)
        - which pod forward request to ? port forward to ?
            - selector - pods are identified via selector in service
                Ex. 
                pod.yaml 
                labels:
                    app: my-app
                    type: microservice
                service.yaml
                selector:
                    app: my-app
                    type: microservice
                spec:
                    targetPort: 3000
            - svc match all replcas, registers as endpoints and must match ALL selectors
            - pod with multiple ports for diff apps 
                - defined in targetPort attribute in service
            - Service Endpoints 
                - create endpoint object when service is created
                - same name as service
                - keeps track of, which pods are members/endpoints of service -> dyanmic as new pod replica as IP address gets updated
                - kubectl get endpoints 
                - In services.yaml, serviceport is arbitary but targetPort must match the port the container is listening at (pod)
        - Service Communcation Example
            - Browser -> Ingress -> Service (ClusterIP 10.128.8.64:3200) -> NodeJS POD replicas (ip address:9000) -> Service (ClusterIP 10.128.19.160:27017) -> MongoDB POD (ip address:27017)
            - MongoDB Pod - multi port services (second container running monitoring metrics - mongo-db exporter at port 9216) -> prometheus container scraps data from mongo-db exporter at 9216
            - Multi port service
                - Service handle two diff requests so need two ports - 27017 for clients to talk to mongodb database and 9216 for clients to talk to mongodb exporter
                - need to name ports in service
                Ex Service YAML for Mongodb pod
                    spec:
                        selector:
                            app: mongodb
                        ports:
                            - name: mongodb  #name ports when multiple ports
                              protocol: TCP
                              port: 27017
                              targetPort: 27017
                            - name: mongodb-exporter
                              protocol: TCP
                              port: 9216
                              targetPort: 9216
        - Headless Service
            - Client communicate with 1 specific pod directly
            - or pods want to talk directly with specific pod
            - service endpoint not useful as select random pods
            - use case : stateful apps. ex databases - mysql, elasticsearch
            - pod replicas are not identical ex. mysql -> master and worker instances, master only allowed to write to db and worker connect to syncronize. new worker pod connect to most recent worker pod to clone for data sync & up to data state. 
            - So, Client needs to figure out IP addresses for each pod
                - 1. API call to K8s API Server ? for all nodes API addresses but app too tied to K8s API and inefficient (all list for everytime connect to specific pod)
                - 2. DNS Lookup -> Client performs DNS Lookup service, returns single IP address (Service ClusterIP) 
                if set clusterIP: None - return Pod IP address instead been connected by service
            - YAML file example:
                apiVersion: v1
                kind: Service
                metadata:
                    name: mongodb-service-headless
                spec:
                    clusterIP: None
                    selector:
                        app: mongodb
                    ports:
                        - protocol: TCP
                          port: 27017
                          targetPort: 27017
                * No cluster IP address assigned to service
            -  When deploy , we have both normal service (load balancing) connecting to mongodb and headless service (to communicate directly with master node for write or pods for data sync)
    - 3 Service type attributes in Service Config
        - ClusterIP
            - spec:
                type: ClusterIP
            - only accessible within cluster
        - NodePort - not used for external connection
            - spec:
                type: NodePort
            - creates service that is accessible on static port for each worked node on cluster, external traffic has access to fixed port on each worker node - browser request directly to port defined as 
            nodePort attribute - predefined range within 30000-32767 (so access via ip-address worker node:nodePort)
            - also has port attribute of service -> clusterIP service automatically created 
            - cluster-ip:3200       node-ip:30008
            - service spans across replicas so browser request on node port can be handled by any of the worker nodes. 
            - nodeport services not secure (access to worker nodes from outside)
        - LoadBalancer (better alternative to nodeport)
            - spec:
                type: LoadBalancer
            - service becomes accessible externally using cloud provider loadbalancers
            - with loadbalancer service, nodeport and clusterip are created automatically and loadbalancer route traffic to them
            - Ex. loadbalancer service.yaml
                apiVersion: v1
                kind: Service
                metadata:
                    name: ms-service-loadbalancer
                spec:
                    type:LoadBalancer
                    selector:
                        app: microservice-one
                    ports:
                        - protocol: TCP
                          port: 3200
                          targetPort: 3000
                          nodePort: 30010
            - loadbalancer sends request via nodeport ext. or cluster ip port
            - Loadbalancer extension of node port and node port extension of cluster ip
    - kubectl get svc 
    - ideal way of setting up external request to service in Prod env.
        - 1. Configure ingress 
                Ingress -> ClusterIP service -> PODS(replica)
        - 2. Use Load Balancer (Cloud provider)
                LoadBalancer -> ClusterIP service -> PODS(replica)







            
             



































        






















































        





















