# How to Run

## Pre Reqs
- ruby 2.5
- rspec 3.9.0 (gem install rspec)

## To execute the application
1. Clone repository locally then edit lib/main.rb. 
2. ruby lib/main.rb

## To execute tests
1. cd to project root
2. rspec --format doc


# Workflow Simulator

This application intends to emulate a Job running framework.

The framework provides the following entities:

- Job: which represents a Job.
- WorkFlow: which represents a logical grouping of Jobs together.
- DependencyResolver: which is in charge of resolving dependencies for correct job execution order.

A Job then will output its name when executed. So will a Work Flow. 

Multiple jobs can be registered to a work flow. And, multiple jobs can be registered as dependencies to a job. Meaning the 
registered upon job will not run until all of its dependent jobs have run.

# Assumptions and Considerations

- Framework is single threaded at this point. 
- If we wished to make this multi threaded we could look into dockerizing and using a swarm. Multi-Thread is tricky in ruby.
- NO CIRCULAR DEPENDENCIES IN JOBS ARE CONSIDERED (dead locks)
- The dependency resolving algorithm is a custom implementation of my own, it was just something to get going. If we 
wanted to improve depedency solving elapsed time and circular dependency detection, we may wanna consider a Topological Sorting 
algorithm, there are plenty online available.

This project is using Ruby NOT Ruby on Rails. RoR seemed like an overkill to me for this use case. 

1. If we wanted to build this into a Service, I would suggest we:
   - Separate away the job/workflow framework into a gem.
   - Change into Sinatra and create CRUD APIs for JOBs and WORKFLOWs. We could define
     easy API contracts using REST for both.
   - I would not use RoR as Sinatra is a lot lighter and we do not really need Views for this. If we needed views there are 
     other JavaScript technologies we could leverage instead of RoR's views.
   - Create APIs for Execution management for Jobs/Workflows. e.g. Execute Workflow, Execute Job etc.
   - Dockerize everything.
   - Move into a multi-threaded model.

2. Current Scaling issues:
   - Framework is single thread... yiuk! Move into multi-threaded to leverage multiple hardware threads.
   - Dockerize in order to be able to leverage Auto Scaling Groups and Swarm/K8s. As well as ease deployment.
   - Jobs without dependency could run in parallel in order to speed execution.
   - Performance/Load/System testing would be nice in order to tune and capacity plan.

3. Potential applications of this workflow manager:
   - This can become a Task Automation framework for Foreground/Background jobs.
   - It can allow asynchrounous decoupling by using a Queue like SQS or RabbitMQ.
 

