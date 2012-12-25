module Better
  module Logger
    class Logger
      attr_accessor :config

      def initialize config
        @config = config

        if config.log_to.is_a? String
          config.log_to = File.open(config.log_to, 'a')
        end

        if config.error_to.is_a? String
          config.error_to = File.open(config.error_to, 'a')
        end
      end

      def log level, message
        if LEVELS[config.log_level] <= LEVELS[level.to_sym]
          send level, message
        end
      end

      def debug message
        config.log_to.puts _format_message(message, __method__)
      end

      def info message
        config.log_to.puts _format_message(message, __method__)
      end

      def warn message
        config.log_to.puts _format_message(message, __method__)
      end

      def error message
        config.error_to.puts _format_message(message, __method__)
      end

      def fatal message
        config.error_to.puts _format_message(message, __method__)
      end

      # Pseudo-private methods

      def _format_message message, level = config.log_level
        if config.formatter
          instance_exec message, level.to_sym, &config.formatter
        else
          message
        end
      end
    end
  end
end
