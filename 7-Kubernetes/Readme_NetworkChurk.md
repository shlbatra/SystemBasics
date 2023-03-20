- Problem with docker containers
    - too much traffic 
    - host going down
- Use load balancer - still how scale up - keep creating containers on servers and add to load balancers. Lot of manual work - make change then go make change to each docker container on each server
- Better solution (Container Orchastration)
- Kubernetes
    - server and container run time (docker)
    - new server - master , call workers, 
    - install k8s on each worker node -> 
        - kubelet, 
        - kubeproxy 
        - docker
    - Master control worker with following components 
        - kubernetes api server
        - scheduler
        - controller manager
        - etcd
- Lab (Set up K8s cluster)
    - create it on Linode (kubernetes cluster)
    - Kubernetes API endpoint (Master) -> API Server talk to cluster
    - Use kubectl to interact with k8s cluster (master node)
    - install kubectl
    - curl <path for kubectl install>
    - chmod +x ./kubectl
    - sudo mv ./kubectl /usr/local/bin/kubectl
- how access cluster in linode ?
    - kubeconfig.yaml
    - export KUBECONFIG=kubeconfig.yaml   (connect to cluster now)
    - kubectl get nodes
    - kubectl cluster-info
- deploy website on k8s cluster
    - create pod & container in pods
    - kubectl run networkchuckcoffee 
                    --image=thenetworkchuck/nccoffee:pourover --port=80
    - kubectl get pods
    - kubectl describe pods 
    - Every pod assigned private IP address - access from k8s node
    - deploy bunch of containers/pods
    - create deployment (3 pod replicas with port 80 open)
    - networkcoffee_deployment.yaml (Manifests)
    -   apiVersion: apps/v1
        kind: Deployment
        metadata:
            name: neyworkchuckcoffee-deployment
            labels:
                app: nccoffee
            spec:
                replicas: 3
                selector:
                    matchlabels:
                        app: nccoffee
                template:
                    metadata:
                        labels:
                            app: nccoffee
                    spec:
                        containers:
                            - name: static-site
                              image: thenetworkchuck/nccoffee:pourover
                              imagePullPolicy: Always
                              ports:
                                containerPort: 80
    - kubectl apply -f nccoffeedeployment.yaml
    - kubectl get pods (3 pods)
    - Desired state - yaml file says 3 pods with image provided, k8s continously checking we at desired state
    - kubectl edit deployment nccoffeedeployment (to modify deployment)
    - master with scheduler - assign jobs accordingly (containers)
    - kubectl get pods -o wide
    - All pods internal IP that we cannot access
- Expose internal IP (pods) using Services
    - Also load balance 
    - networkchuckcoffe_service.yaml
        apiVersion: v1
        kind: Service
        metadata:
            name: coffee-service
            annotations:
                service.beta.kubernetes.io/linode-loadbalancer-throttle: "4"
            labels:
                app: coffee-service
        spec: 
            type: LoadBalancer
            ports:
            - name: http
              port: 80
              protocol: TCP
              targetPort: 80
            selector:
                app: nccoffee      #which pods load balance 0 with this app label
            sessionAffinity: True
    - kubectl apply -f coffee-service.yaml
    - kubectl get services
    - created load balancer in k8s and cloud 
        - in linode -> get IP address and port
    - kubectl describe services coffee-service
    - get endpoints for all pods
    - if update website then easy to update everything with k8s
        - kubectl edit deployment <deploymentname>
            - replicas: 20
            - image: <new image name>
        - kubectl get pods  (terminating and creating new pods)
        - kubectl get services 
        - kubectl get services coffee-service (automatically load balancing 20 pods now)
    - clean up all services
        - in linode
            - k8s cluster -> delete 
            - node balancer -> delete
             
      










