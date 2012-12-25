require_relative '../lib/better-logger'

Better::Logger.config do |conf|
  conf.color = true
  conf.log_to = STDOUT
  conf.error_to = STDERR
  conf.log_level = :debug
end

class Foo
  def bar
    log.debug "Yes"
    log.info  "Np"
    log.warn  "Oops!"
    log.error "Test"
    log.fatal "wat"
  end
end

Foo.new.bar

log.info "Done."
