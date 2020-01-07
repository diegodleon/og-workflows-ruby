module OpenGov
  module Contract
    class Executable
      def execute
        # This method is to be overriden by inheriting classes.
        puts "Override me!"
      end
    end
  end
end