require 'spec_helper'
require 'model/dependency_resolver'

describe OpenGov::Model::DependencyResolver do
  let(:job1) {OpenGov::Model::Job.new("TEST_JOB1")}
  let(:job2) {OpenGov::Model::Job.new("TEST_JOB2")}
  let(:job3) {OpenGov::Model::Job.new("TEST_JOB3")}

  context 'when an empty job_list' do 
    let(:dependency_resolver) {OpenGov::Model::DependencyResolver.new([])}

    it 'returns an empty executionQ' do 
      expect(dependency_resolver.get_execution_q.empty?).to eq(true) 
    end
  end

  context 'when multiple elements and no dependencies in job_list' do 
    let(:job_list) {[job1, job2, job3]}
    let(:dependency_resolver) {OpenGov::Model::DependencyResolver.new(job_list)}

    it 'includes all jobs registered' do
      execution_q = dependency_resolver.get_execution_q
      
      expect(execution_q).to include(job1)
      expect(execution_q).to include(job2)
      expect(execution_q).to include(job3)
    end
  end

  context 'when multiple elements and dependencies in job_list' do 
    let(:job_list) {[job1, job2, job3]}
    let(:dependency_resolver) {OpenGov::Model::DependencyResolver.new(job_list)}

    it 'includes all jobs registered in correct execution order' do
      job1.add_dependency(job2, job3)
      job2.add_dependency(job3)

      execution_q = dependency_resolver.get_execution_q
      
      expect(execution_q[0]).to eq(job3)
      expect(execution_q[1]).to eq(job2)
      expect(execution_q[2]).to eq(job1)
    end
  end
end