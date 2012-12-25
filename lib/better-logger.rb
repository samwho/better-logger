lib = File.dirname(__FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

def require_all path
  Dir[File.join(File.dirname(__FILE__), path, '*.rb')].each { |f| require f }
end

require 'colored'

require     'better-logger/base'
require_all 'better-logger'

# Make the logging methods available from everywhere
include Better::Logger::Loggers
