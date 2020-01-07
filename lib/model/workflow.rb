require_relative '../contract/executable'

module OpenGov
  module Model
    class WorkFlow < OpenGov::Contract::Executable
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def job_list
        @job_list ||= Array.new
      end

      def register(*jobs)
        jobs.each { |job| job_list << job }
      end

      # Override
      def execute
        puts "Executing Workflow #{name}:"

        calculate_execution_q.each {|job| job.execute}

        puts "Workflow Complete!!"
      end

      private

      def calculate_execution_q
        OpenGov::Model::DependencyResolver.new(job_list).get_execution_q
      end
    end
  end
end