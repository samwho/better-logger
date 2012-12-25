module Better
  module Logger
    class Config
      attr_writer :color, :formatter, :log_to, :datetime_format, :log_level,
        :error_to, :time_format

      def color
        @color = true if @color.nil?
        @color
      end

      def color?
        color
      end

      def log_to
        @log_to ||= STDOUT
      end

      def error_to
        @error_to ||= STDERR
      end

      def log_level
        @log_level ||= :info
      end

      def time_format
        @time_format ||= "%Y/%m/%d %H:%M:%S"
      end

      def formatter
        @formatter ||= lambda do |message, level|
          _level = level.to_s.ljust(5)
          _time  = Time.now.strftime(config.time_format)

          if config.color?
            case level
            when :debug
              _level = _level.magenta
            when :info
              _level = _level.cyan
            when :warn
              _level = _level.yellow
            when :error
              _level = _level.red
            when :fatal
              _level = _level.red
            end
          end

          "[#{_time}][#{_level}][#{caller[3]}] #{message}"
        end
      end
    end
  end
end
