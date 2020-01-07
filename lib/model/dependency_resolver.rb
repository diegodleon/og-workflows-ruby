require 'Set'

module OpenGov
  module Model
    class DependencyResolver

      def initialize(job_list)
        @job_list = job_list
        @execution_q = Array.new
        @traversed_jobs = Set.new
      end

      def get_execution_q
      	idx = nil
        while !@job_list.empty?
          idx = 0 if idx.nil? || (idx + 1) > @job_list.length

          current_job = @job_list[idx]

          if dependency_ready_for?(current_job)
            mark_traversed(current_job)
            @execution_q << current_job
            @job_list.delete(current_job)
            idx = 0
          else
            idx += 1
          end
        end
        @execution_q
      end

      private

      def mark_traversed(job)
        @traversed_jobs.add(job)
      end

      def dependency_ready_for?(job)
      	job.dependency_set.subset?(@traversed_jobs)
      end

    end
  end
end