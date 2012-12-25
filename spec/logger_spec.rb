require 'spec_helper'

describe Better::Logger do
  let(:fake_stdout)         { Tempfile.new 'fake_stdout' }
  let(:fake_stderr)         { Tempfile.new 'fake_stderr' }
  let(:fake_stdout_content) { fake_stdout.rewind; fake_stdout.read }
  let(:fake_stderr_content) { fake_stderr.rewind; fake_stderr.read }

  before :each do
    Better::Logger.config :log do |conf|
      conf.color = true
      conf.log_to = fake_stdout
      conf.error_to = fake_stderr
      conf.log_level = :debug
    end
  end

  after :each do
    fake_stdout.close; fake_stdout.unlink
    fake_stderr.close; fake_stderr.unlink
  end

  describe "log#info" do
    subject { fake_stdout_content }
    before  { log.info "Testing!" }
    it      { should include "Testing!" }
    it      { should include "info" }
  end

  describe "log#error" do
    subject { fake_stderr_content }
    before  { log.error "Error test!" }
    it      { should include "Error test!" }
    it      { should include "error" }
  end
end
