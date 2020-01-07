require 'spec_helper'
require 'model/workflow'

describe OpenGov::Model::WorkFlow do
  subject { OpenGov::Model::WorkFlow.new("TEST_WORKFLOW")}
  
  let(:job1) {OpenGov::Model::Job.new("TEST_JOB1")}
  let(:job2) {OpenGov::Model::Job.new("TEST_JOB2")}
  let(:job3) {OpenGov::Model::Job.new("TEST_JOB3")}

  describe '#register' do
  	it 'registers a single job' do
  	  subject.register(job1)

  	  expect(subject.job_list).to include(job1)
  	end

  	it 'registers multiple jobs' do
  	  subject.register(job1, job2)

  	  expect(subject.job_list).to include(job1)
  	  expect(subject.job_list).to include(job2)
  	end
  end

  describe '#execute' do
  	it 'executes the workflow' do
  	  expect(subject).to receive(:execute)
  	  subject.execute
  	end
  end
end