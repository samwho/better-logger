module Better
  module Logger
    LEVELS = {
      debug:  0,
      info:   1,
      warn:   2,
      error:  3,
      fatal:  4,
      silent: 100,
    }

    def self.config log_name = :log, &block
      conf_object = Config.new
      yield conf_object

      # The "Loggers" module gets included into the main namespace when
      # better-logger is required. By defining a method in it, we define a
      # method in the main namespace. This allows the loggers to be accessed
      # from anywhere.
      Loggers._log_hash[log_name] = Logger.new(conf_object)
      Loggers.send :define_method, log_name do
        Loggers._log_hash[log_name]
      end
    end
  end
end
