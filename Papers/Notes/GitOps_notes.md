
### **Gitops**
- https://www.gitops.tech/
##### Why should I use GitOps?
- deploy faster more often
    - everything happens in version control
- Easy and Fast Recovery
    - git revert
- Easier Credential Management
    - Self service ( no creds for perform operation)
    - can be stored in jenkins secrets manager
- self documenting deployments
    - source of truth is the repo
- shared knowledge in teams

##### Push vs pull
- more info below



### **Modern Devops practices by Agarwal**
> ch 13 Understanding Devops with Gitops
##### Principles of GitOps
> Key Principles 
        - Describes the entire system Declaratively
        - Version Desired system state by using Git
        -  It uses tooling to automatically apply approved changes
        - it uses self healing agents to alert and correct any divergence
##### The Branching Strategy and GitOps Workflow
> GitOps requires at least two kinds of Git repositories to function: the application repository from where your builds are triggered and the environment repository that contains all of the infrastructure and configuration as code. 

- push model 
    - The push model pushes any changes that occur within your Git repository to the environment
    - model is unaware of the existing configuration and reacts only to changes made by your git repos
    - set up monitoring to understand whether there are any deviations
    - creds need to be store in tools
    - tool typically used
        - jenkins for ci
        - terraform provisioning
        - ansible for config management
        - rundeck 
- pull model
    -The pull model is an agent-based deployment model (which is also known as an operator-based deployment model).
    - agent monitors the git repo for changes 
    - agent constantly compares the existing configuration with the desired state 
    - alerts when desired state is unable to be met
    - creds lives with the agent
    - ? maybe using WA as the agent

- most orgs implement a hybrid model

##### Structuring the Git Repo
> To implement GitOps, we require at least two repositories: the application repository and the environment repository. 
- will use the app folder as our scripts folders
    - app code end up in containers
        - avoid versioning issues py 2 vs py 3 or ps 3 vs ps 5.1
    - branching strageies to manage your code
        - gitflow
            - requires several kinds of branches (for instance, master branches, hotfixes, release branches, develop, and feature branches) and has a rigid structure. 
            - doesn't seem ideal for us as tool builders
        -Github Flow 
            - contains a single master branch
            - branches that eventually merge with master
            - ideal for us 
- Environment Repo 
    - stores the env specific configurations that are needed to run the application code
    - docker, terraform, and ansible come in play


### **GitOps and Kubernetes by Manning**
> first coin in 2017 by weaveworks 
##### GitOps
- Operate on the desired state of the system that is stored in Git
- Detect differences between the desired state and the actual state
- Perform the required operations on the infrastructure to synchronize the actual state with the desired state
- you should avoid directly modifying the system outside of GitOps.
###### Benefits
- IaC
    - repeatability 
    - reliability
    - efficiency 
    - saving 
    - visibility
- self service
    - instead of sending a ticket, you give a self service portal 
    - provides constant, secure, approved changes to the system 
- code reviews
    - peer reviews
    - awareness of changes 
    - second pair of eyes
    - Consistency in design and implementation
    - teaching and sharing knowledge
    - team cohesion
- Git pull requests 
    - Pull requests can be used to enforce premerge code reviews. 
    - Controls can be put in place to require specific testing or approval before a pull request is merged to the main branch. 
- Declarative 
    - idempotency 
- Observability
    - monitoring state 
    - you see configuration drift
    - *Latency*
        -The time it takes to deploy and make the system’s running state match its desired state
    - *Traffic*
        - Frequency of deployments
        - The number of deployments in progress
    - *Errors*
        - The number of deployments that failed and the current number of deployments in a failed state
        - The number of out-of-sync deployments where the system’s running state does not match its desired state
    - *Saturation*
        - Length of time a deployment has been queued and not processed
    - *app liveness*
    - *app readiness*     
- auditability and compliance
- Disaster Recovery
    - revert changes

### **Building Secure and Reliable Systems by Google** *Designing Systems*
- *Design for Least Privilege*
    - how to evaluate access based upon risk—is an excellent place to start. 
- *Design for Understandability*
    - analyze and understand your systems through invariants and mental models. 
    - Using a layered system architecture built on standardized frameworks for identity, authorization, and access control.
    - To respond to a shifting risk landscape, 
        - be able to change your infrastructure frequently and quickly while also maintaining a highly reliable service. 
- *Design for a Changing Landscape*
    - presents practices that let you adapt to short-, medium-, and long-term changes, as well as unexpected complications that might arise as you run a service.

- The guidelines mentioned thus far will have limited benefits if a system cannot withstand a major malfunction or disruption.

- *Design for Resilience* 
    - discusses strategies for keeping a system running during an incident, perhaps in a degraded mode.
    - possible look at chaos engineering  
- *Design for Recovery*
    - approaches systems from the perspective of fixing them after breakage
    - principles of SRE 

### Goal: Understand the ***current state*** vs ***desired state***
> how do we obtain these two states
- sli, slo, and sla with Observability
- error budgets
- I propose that we start with QA tests
    - any changes to the system that we make always need to be validate for the desired state
    - lets get that first and we have a baseline