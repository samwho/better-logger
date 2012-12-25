class Foo
  include Better::Logger

  def initialize
    debug "Initialize entered."
  end

  def bar
    error "Oh noes! Something went wrong!"
  end
end
