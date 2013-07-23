require "spec_helper"
require "wordpress/base"

describe Wordpress::Base do
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
