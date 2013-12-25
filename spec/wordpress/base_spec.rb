require "spec_helper"
require "wordpress/base"

describe Wordpress::Base do
  describe "attr_accessor class method" do
    it 'should overwrite attr_accessor class method' do
      klass = Class.new(Wordpress::Base)
    end

    it 'should return default value' do
      klass = Class.new(Wordpress::Base) do
        attr_accessor :key => :default_value
      end
      ins = klass.new
      ins.key.should == :default_value
      ins.key = :new_value
      ins.key.should == :new_value
      ins.key = nil
      ins.key.should be_nil
    end
  end

  describe "logger instance" do
    let :instance do
      Wordpress::Base.new
    end

    it "should have logger accessor" do
      instance.should respond_to(:logger)
    end

    it "should have logger method accessor" do
      instance.should respond_to(:debug)
      instance.should respond_to(:info)
      instance.should respond_to(:warn)
      instance.should respond_to(:error)
      instance.should respond_to(:fatal)
    end
  end
end
