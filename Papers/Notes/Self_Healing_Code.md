# Self-Healing Code A Journey through Auto-Remediation
> Managing modern product infrastructure and applications is daunting because the bigger the infrastructure, more complicated the operational challenges you face. 
- if you keep adding monitoring
    - end up huge pile of alerts and failures everyday
- ensure availability as you scale through automation 
- auto-remediation aka self-healing
    - workflow which triggers and responds to alerts or events by executing actions that prevent or fix the problem 

### The Start of our Journey 
> Motivated by the constant stream of alerts and common issues we saw, we worked toward building a system to automatically remediate some of these alerts
- usage of reactors and orchestrators 

### The Details of our journey 
> We realized that some of the actions didn't require human intelligence to handle them 
- generic framework
    1. Detect failure
        - monitoring system
    2. Notify "the system" of failure event(including hostname and service is alerting)
    3. "The system" listens for failure events and triggers auto-remediation response
        - response may need to run commands on a remote box; so, it would need remote access
    4. Logging of all actions and attempts to remediate
        - to monitor and improve "the system"
        - config manager 

### Final Architecture
1. Minion scheduler executes local script to detect failure
2. On failure, script sends custom salt event
3. Custom event sent to salt master
4. salt reactor matches custom event, launches salt orchestrator 
5. Salt orchestrator launches salt state(s) on minion to remediate failure
    - orchestrator also logs remediation 

##### Detecting failures 
> Use the scheduler in salt minions to execute a script on a regular interval. 

##### Sending notification of failures as salt events 
> when the script finds warnings or failures, it sends the event to salt 

### Stopping auto-remediation as needed per host
> Cases where the auto-remediation will need to be turn-off. It will interfere with maintenance 
