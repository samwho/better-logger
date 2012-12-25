module Better
  module Logger
    class Config
      attr_writer :color, :formatter, :datetime_format, :log_level, :time_format

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

      def log_to= new_log_to
        if new_log_to.is_a? String
          @log_to = File.open(new_log_to, 'a')
        else
          @log_to = new_log_to
        end
      end

      def error_to
        @error_to ||= STDERR
      end

      def error_to= new_error_to
        if new_error_to.is_a? String
          @error_to = File.open(new_error_to, 'a')
        else
          @error_to = new_error_to
        end
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
