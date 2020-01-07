require 'set'

require_relative '../contract/executable'


module OpenGov
  module Model 
    class Job < OpenGov::Contract::Executable
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def add_dependency(*jobs)
        jobs.each {|job| dependency_set.add(job)}
      end

      # Overriden
      def execute
       puts "Executing Job #{name}"
      end

      def dependency_set
        @dependency_set ||= Set.new
      end
    end
  end
end