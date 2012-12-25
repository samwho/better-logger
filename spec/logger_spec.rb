require 'spec_helper'

describe Better::Logger do
  let(:fake_stdout)         { Tempfile.new 'fake_stdout' }
  let(:fake_stderr)         { Tempfile.new 'fake_stderr' }
  let(:fake_stdout_content) { fake_stdout.rewind; fake_stdout.read }
  let(:fake_stderr_content) { fake_stderr.rewind; fake_stderr.read }

  before :each do
    Better::Logger.config :log do |conf|
      conf.color     = false
      conf.log_to    = fake_stdout
      conf.error_to  = fake_stderr
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
    it      { should include "[info ]" }
  end

  describe "log#info multiple calls" do
    subject { fake_stdout_content }

    before do
      log.info "Info test!"
      log.info "Info test 2!"
    end

    it { should include "Info test!" }
    it { should include "Info test 2!" }
  end

  describe "log#error" do
    subject { fake_stderr_content }
    before  { log.error "error test!" }
    it      { should include "error test!" }
    it      { should include "[error]" }
  end

  describe "log#error multiple calls" do
    subject { fake_stderr_content }

    before do
      log.error "error test!"
      log.error "error test 2!"
    end

    it { should include "error test!" }
    it { should include "error test 2!" }
  end

  describe "log#debug" do
    subject { fake_stdout_content }
    before  { log.debug "debug test!" }
    it      { should include "debug test!" }
    it      { should include "[debug]" }
  end

  describe "log#debug multiple calls" do
    subject { fake_stderr_content }

    before do
      log.error "debug test!"
      log.error "debug test 2!"
    end

    it { should include "debug test!" }
    it { should include "debug test 2!" }
  end

  describe "With color" do
    before :each do
      Better::Logger.config :log do |conf|
        conf.color     = true
        conf.log_to    = fake_stdout
        conf.error_to  = fake_stderr
        conf.log_level = :debug
      end
    end

    describe "log#fatal" do
      subject { fake_stderr_content }
      before  { log.fatal "fatal test!" }
      it      { should include "fatal test!" }
      it      { should include "[#{"fatal".red}]" }
    end
  end

  describe "With a different formatter" do
    before :each do
      Better::Logger.config :log do |conf|
        conf.color     = true
        conf.log_to    = fake_stdout
        conf.error_to  = fake_stderr
        conf.log_level = :debug

        conf.formatter = lambda do |message, level|
          "#{level.upcase} #{message.upcase}"
        end
      end
    end

    describe "log#warn" do
      subject { fake_stdout_content }
      before  { log.warn "warn test!" }
      it      { should == "WARN WARN TEST!\n" }
    end
  end

  describe "Non-default logging method" do
    before :each do
      Better::Logger.config :testlog do |conf|
        conf.color     = true
        conf.log_to    = fake_stdout
        conf.error_to  = fake_stderr
        conf.log_level = :debug
      end
    end

    describe "testlog#info" do
      subject { fake_stdout_content }
      before  { testlog.info "testlog!" }
      it      { should include "testlog!" }
    end
  end

  describe "Slightly raised log level" do
    before :each do
      Better::Logger.config :testlog do |conf|
        conf.color     = true
        conf.log_to    = fake_stdout
        conf.error_to  = fake_stderr
        conf.log_level = :info
      end
    end

    describe "log#debug" do
      subject { fake_stdout_content }
      before  { testlog.debug "I shouldn't be in the output." }
      it      { should be_empty }
    end
  end
end
