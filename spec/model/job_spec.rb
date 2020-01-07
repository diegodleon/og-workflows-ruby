require 'spec_helper'
require 'model/job'

describe OpenGov::Model::Job do
  subject {OpenGov::Model::Job.new("TEST_JOB")}

  describe '#add_dependency' do
  	let(:job1) {OpenGov::Model::Job.new("TEST_JOB1")}
  	let(:job2) {OpenGov::Model::Job.new("TEST_JOB2")}
  	let(:job3) {OpenGov::Model::Job.new("TEST_JOB3")}

    it 'adds a single dependency' do
      subject.add_dependency(job1)

      expect(subject.dependency_set).to include(job1)
    end

    it 'adds multiple dependencies' do
      subject.add_dependency(job2, job3)

      expect(subject.dependency_set).to include(job2)
      expect(subject.dependency_set).to include(job3)
    end
  end

  describe '#execute' do
    it 'executes the job' do
      expect(subject).to receive(:execute)
      subject.execute
    end
  end
end