# Site Reliability Engineering Adoptions: Setting up the Fundamentals - Spyridon Maniotis
> The purest distillation of devops principles into a particular role 

### Origin and Essence
---
- Origin
    - "Fundamentally, its what happens when you ask a software engineer to design an operations functions" Ben Treynor, VP Eng
- Essence
    - Focus on prescriptive ways of measuring and achieving reliability through engineering and operations work
    - SRE reading it backwards
        - engineering the reliability of the service 
    - Class SRE implements DevOps

### Fundamental 1: Tenets and Balance
---
> Tenant
> : the basic and common set of responsibilities across SRE teams
- Operations and improvements are 50/50
    - in the long run we are aiming for 20/80
##### Operations
- Emergency Response
    - incidents of service or application 
    - first level reaction (if the self healing fails)
- Observability
    - monitoring
    - logging
    - four golden signals 
    - dep
- Postmortems
    - analysis
    - preventative measures
- Deployments
    - able to revert in disasters 
- Service Continuity
    - plan to not to lose service after disasters 

##### Improvements
- Eliminate Toil
    - autonomous operations and hands off
- Reliability
- Technical Debt
    - managing error budget
- Capacity Management
    - using historical data
    - predict for intended growth
    - how to scale application
- Release Engineering
    - release velocity vs reliability 
- Transformation initiatives
    - eg moving towards cloud native
    - eg moving towards serverless

### Fundamental 2: Topologies
---
> Reconcile with your broader DevOps operating model and ecosystem

1. Embedded - Organic(full ownership)
    - Business Context ecosystem(FRTB*)
    - looking at the ecosystem and tactically placing the people and get them harmonize
    - strong as your weakest link
    - having a core infra
2. Task Force - Tactical (come > stabilize> transfer knowledge> move on)
    - when the services don't have direct dependencies
    - center of excellence
        - groups of SRE throw into teams

### Fundamental 3: Frameworks
---
> Prescriptive = "legally" established and/or accepted. You need to be consistent!
> The success in this stage sets up for future teams

##### Observability
- health visibility 
    - health status
    - alerts
- Chaos Engineering
    - data to curate your system
    - stress test
- Capacity Planning 
    - predicate usage 

##### Autonomous IT Service Management
- Autonomous Operations
- Even-Driven
- Interoperate with release engineering

##### Releasing Engineering
- Balance of control and innovation
    - Equilibrium of release velocity and reliability
- CI/CD Orchestration
- Compliance as Code

##### Production Readiness Review
- Ensure Service Production Readiness
    - liveness probes
    - readiness probes
- Guidelines on completeness across the software development life cycle
- the gatekeeping of SRE in order to take over a service/releases in production

### Fundamental 4: Reconcile with "Traditional" ITSM
---
> The relation **<u>is not</u>** conflictual (unless you force it to be, don't do that)
> Google's ITSM microservice management flavor

**IT Infrastructure Library** (Process Definition and Governance) |  **Site Reliability Engineering** (Process Engineering)
---|---
Problem Management | Post Mortems
Release Management | Release Engineering
Service Level Management | SLOs, SLIs, SLAs, MTTR, Error Budgets
Service Transition | Proudction Readniess
Service Continuity | Chaos Engineering


### T-Shaped Composition
---
> A tricky (but rather creative) quest to resolve
> every service has different needs
> every member should have an engineering background and be able to code

T-Shaped Composition 
- Cross-Discipline Expertise
- Deep Disciple Expertise
    - a capability and skillset matrix will be handy

Primarily and Secondary for each profile
1. Software  
2. Operations
3. Release
4. Quality Assurance 
5. Security and Compliance
6. Automation 
7. Cloud Native 
8. Infrastructure
9. Lead

Gotchas 
---
 1. Responsibly Lazy
 2. Do not sell it as only "automation'
    - its fallacy, automation is the only one of tenants
    - lose what its really about
 3. Shift to the extreme left
 4. Don't force people into the role
    - take who voluntary for the role
 5. Difficult to attract; incubate to the role
 6. Do the math
    - collect baselines
    - compare metrics
    - can show success
7. Make your segregation of duty policies are SRE friendly
8. Reconcile, Reconcile, Reconcile

    

ops > playbook  > observability > upskill> automation  > self service