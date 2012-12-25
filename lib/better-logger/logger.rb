module Better
  module Logger
    class Logger
      attr_accessor :config

      def initialize config
        @config = config
      end

      def debug msg; _log config.log_to, __method__,   msg; end;
      def info  msg; _log config.log_to, __method__,   msg; end;
      def warn  msg; _log config.log_to, __method__,   msg; end;
      def error msg; _log config.error_to, __method__, msg; end;
      def fatal msg; _log config.error_to, __method__, msg; end;

      # Pseudo-private methods

      def _format msg, level = config.log_level
        if config.formatter
          instance_exec msg, level.to_sym, &config.formatter
        else
          msg
        end
      end

      def _should_log? level
        # :info <= :debug
        # 1     <= 0
        LEVELS[config.log_level] <= LEVELS[level.to_sym]
      end

      def _log io, level, msg
        io.puts _format(msg, level) if _should_log? level
      end
    end
  end
end
