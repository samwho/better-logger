# Better::Logger

Better Logger is designed to be a replacement for the standard library logging
gem. There are a couple of things about the standard library gem that I don't
quite like:

  - It puts errors in the same place as debug and info messages. I'd prefer my
  logger to put errors in STDERR and everything else in STDOUT.

  - Lots of people declare their loggers in different ways, there's no
  convention around logging. I'd much prefer to be able to specify a
  configuration block and then have a globally accessible logger.

  - The default format of log output in the Ruby standard logger isn't very
  useful in my opinion. I would prefer a default that has colours and
  information about where in the code the log message came from.

This gem attempts to address all of these things. You may prefer the standard
Ruby implementation, and that's totally fine, I built this for me originally and
wanted to share it :)

## Installation

Add this line to your application's Gemfile:

    gem 'better-logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better-logger

## Usage

First thing you need to do is configure your logger:

``` ruby
require 'better-logger'

Better::Logger.config do |conf|
  conf.color     = true
  conf.log_to    = STDOUT
  conf.error_to  = STDERR
  conf.log_level = :info
end
```

After this configuration block you will have access to a `log` object from
everywhere in your code. Its usage should be familiar:

``` ruby
# The following log methods are listed in order of their severity from least to
# most severe.

log.debug "This is a debug message. It goes to conf.log_to"
log.info  "This is an info message. It goes to conf.log_to"
log.warn  "This is a warn message. It goes to conf.log_to"
log.error "This is an error message. It does to conf.error_to"
log.fatal "This is also an error but more sever. It also goes to conf.error_to"
```

### Multiple logs

It's possible to have multiple logs in the same piece of code by passing a
symbol into the configure blocks:

``` ruby
require 'better-logger'

Better::Logger.config :log1 do |conf|
  conf.color     = true
  conf.log_to    = STDOUT
  conf.error_to  = STDERR
  conf.log_level = :info
end

Better::Logger.config :log2 do |conf|
  conf.color     = true
  conf.log_to    = "log_output.log"
  conf.error_to  = "log_error.log"
  conf.log_level = :info
end

log1.info "Going to STDOUT."
log2.info "Going to a file called 'log_output.log' in the current directory."
```

### Modifying logs after creation

You can access and modify the configuration of a log after its creation simply
by modifying its `config` object:

``` ruby
require 'better-logger'

Better::Logger.config do |conf|
  conf.color     = true
  conf.log_to    = "log_output.log"
  conf.error_to  = "log_error.log"
  conf.log_level = :info
end

log.info "Logging to a file called 'log_output.log'"

log.config.log_to = STDOUT

log.info "Logging to STDOUT."
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
