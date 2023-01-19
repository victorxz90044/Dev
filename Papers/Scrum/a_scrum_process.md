# Scrum Process
---

### Summary
Built out a scrum process to have more visibility into the work of the team. Create metrics for projects complete times.


### Intended Goals
---
- Workload visibility 
- Project Completion Predication 

##### Functional Requirements
- metrics for predication
- handling unplanned work
- funnel external teams requests
- handovers

##### Non-functional Requirements
- workload visibility 
- Protect the sprint

##### Extended Requirements
- light framework

##### Scope
- Automation Team 


### Capacity Estimation and Constraints
--- 
- time zones
- handoffs
- scope vs personnel 


### High Level Design
---
- **Daily Standup**
    - post in channel
    - 15 mins 
    - cameras on 
- **Sprint Planning** (week that the sprint ends)
    - 30 min meeting
    - Team
- **Sprint Retro** (bi weekly)
    - 15 min meeting
    - Team
'#' Sprint Planning and retro could be one 
- **Backlog grooming** (bi weekly)
    - 30 min
    - Team, SM
- **Backlog refinement** (weekly)
    - 30 min meeting 
    - Dev Manager, PM, Customers
- **Work Ingestion**
    - forum
    - customers


### Detailed Design 
---
- **Daily Standup** (team)
    - Yesterday, Today, Impediments(Blockers)

- **Sprint planning** (team)
    - once a sprint
    - decide what to had for the next sprint

- **Sprint retro** (team)
    - What we did good
    - what we can improve

- **Backlog grooming** (team)
    - measuring the stories

- **Backlog refinement** (scrum master and PM)
    - setting priorities to the projects and stories

- **Work ingestion** (Dev Manager, PM, Customers) 
    - how to deal with unplanned work
    - form to fill out (customers or engineers)
        - bug
        - feature change
        - feature request

- **inception of work**
    1. idea
    2. project
    3. Spikes - questions
    4. epic
    5. story
    6. task
        - Attend audience, I want to, So that
        - acceptance criteria
            - scope and boundaries
                - its should do this
                - its should not do that
- **QA**
    - PR
    - language specific standards 
    - unit tests
    - integration tests
    - smoke tests

### Concerns
___
- alot of admin (tracking)
	- easier to admin
	- forums/templates for ingestion 
- timezones (handoffs)
- plan/unplan ratio
-  filter through ops

### Phases
---
1. Prep Work
	- Backlog refinement
	- Templates for stories and epics(projects)
	- Scrum definitions
	- Addressing concerns
	- auto daily population from Monday (in progress and blockers)
2. Foundations
	- setting up ceremonies 
	- refine work ingestion 
	- learning to protect the sprint
	- reinforcement of standards
		- QA processes 
3. Refinement 
	- define what's working and what's not 
	- determine if the information generated is enough for forecasting
	- QA