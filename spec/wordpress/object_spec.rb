require "spec_helper"

describe Wordpress::Object do
  it 'should respond to attr_parameter method' do
    klass = Wordpress::Object
    klass.should respond_to :attr_parameter
  end

  it 'should define methods for initial parameters' do
    klass = Class.new(Wordpress::Object) do
      attr_parameter :param
    end
    ins = klass.new
    ins.should respond_to(:param)
    ins.should respond_to(:param=)
    ins.should_not respond_to(:unknown)
    ins.should_not respond_to(:unknown=)
  end

  it 'should define methods for initial parameters' do
    klass = Class.new(Wordpress::Object) do
      attr_parameter :param
      attr_parameter :param_as_klass, :as => Array
      attr_parameter :param_as_proc, :as => lambda { |v| v.to_s }
    end
    ins = klass.new(:param => 1, :param_as_klass => 1, :param_as_proc => 1)
    ins.param.should == 1
    ins.param_as_klass.should == [nil]
    ins.param_as_proc.should == '1'
  end
end
