require_relative 'model/job'
require_relative 'model/workflow'
require_relative 'model/dependency_resolver'

# Edit this method as you please
# to test stuff out
# then ruby lib/main.rb
def main
  job1 = OpenGov::Model::Job.new("My_Job_1")
  job2 = OpenGov::Model::Job.new("My_Job_2")
  job3 = OpenGov::Model::Job.new("My_Job_3")  

  job1.add_dependency(job2, job3)
  job2.add_dependency(job3)

  workflow = OpenGov::Model::WorkFlow.new("My_Workflow")
  workflow.register(job1, job2, job3)

  workflow.execute
end

####################################
#
#       Main program execution
#
####################################
main
