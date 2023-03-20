# Cloud Deployment Has Never Been Easier

Depending on the technology and type of cloud product you choose, cloud deployment can be intimidating, but it's often not that complex. In todays video I'll walk you through a couple of fairly simple methods for deploying an application, that don't call for a deep understanding of devops and are quick and easy to implement.

- Pulumi - infra as code platform for cloud deployment
- Easiest way to deploy on cloud
    - Lambda functions, Google Cloud Fns
    - let cloud provider run your code and attach that to url
    - little control over how code is run on Infra
    - not require dockerfile
- Run a container built with docker for more control (AWS - Fargate, Google - Cloudrom)
- for full control, create your own cluster run by container orchestration system (kubernetes)
- set up google cloud 
    - set up google cloud sdk
    - authenticate (gcloud auth login)
    - create project to work  (gcloud config set project sahil-pulumi)
- Pulumi -> create cloud resources using code 
    - write in code in fav language 
    - authenticate pulumi (gcloud auth application-default login)
    - pulumi up #to create infra resources
    - create stack for deployment (dev / prod) 
    - ex. pulumi new gcp-python -> get yaml file 
    - indicate what project is doing -> add config there, ex. Pulumi.dev.yaml, tell in which project resources need to be created
    - pulumi destroy -> destroy all resources created, stack still stays
    - pulumi stack rm dev -> deletes stack as well
- cloud run
    - define dockerfile and run docker file in cloud, Google takes care of scaling
    - create component subclass and define resources assosciated to that class
- make sure install dependencies in venv for pulumi
    - command -> venv/bin/pip install -r requirements.txt
- generic layer define cloud resources indepedent of which cloud provider they are running on
- kuberenetes and infra as a code allows to do this. 