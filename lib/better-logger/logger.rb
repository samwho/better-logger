module Better
  module Logger
    class Logger
      attr_accessor :conf

      def initialize conf
        @conf = conf

        if conf.log_to.is_a? String
          conf.log_to = File.open(conf.log_to, 'a')
        end

        if conf.error_to.is_a? String
          conf.error_to = File.open(conf.error_to, 'a')
        end
      end

      def log level, message
        if LEVELS[conf.log_level] <= LEVELS[level.to_sym]
          send level, message
        end
      end

      def debug message
        conf.log_to.puts _format_message(message, __method__)
      end

      def info message
        conf.log_to.puts _format_message(message, __method__)
      end

      def warn message
        conf.log_to.puts _format_message(message, __method__)
      end

      def error message
        conf.error_to.puts _format_message(message, __method__)
      end

      def fatal message
        conf.error_to.puts _format_message(message, __method__)
      end

      # Pseudo-private methods

      def _format_message message, level = conf.log_level
        if conf.formatter
          instance_exec message, level.to_sym, &conf.formatter
        else
          message
        end
      end
    end
  end
end
