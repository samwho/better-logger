module Better
  module Logger
    module Loggers
      def self._log_hash
        @@log_hash ||= {}
      end
    end
  end
end
