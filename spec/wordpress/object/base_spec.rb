require "spec_helper"
require 'wordpress/object/base'

describe Wordpress::Object::Base do
  describe "attr_parameter class method" do
    it "should add parameter" do
      klass = Class.new(Wordpress::Object::Base)
      klass.send(:options).should_receive(:[]=).with('id', anything)
      klass.class_eval do
        attr_parameter :id
      end
    end

    it "should keep parameters per class" do
      klass = Class.new(Wordpress::Object::Base)
      klass.class_eval do
        attr_parameter :id1
      end
      klass.options.should include('id1')
      klass.options.should_not include('id2')

      klass = Class.new(Wordpress::Object::Base)
      klass.class_eval do
        attr_parameter :id2
      end
      klass.options.should_not include('id1')
      klass.options.should include('id2')
    end
  end

  subject :base do
    Class.new(Wordpress::Object::Base) {
      attr_parameter :foo
    }.new
  end

  it "should delegate [] method to get_object" do
    base.should_receive(:get_object).with('foo').once
    base[:foo]
  end

  it "should get object by getter" do
    base.should_receive(:get_object).with('foo').once
    base.foo
  end

  it "should return nil for unknown method" do
    base[:bar].should be_nil
  end

  it "should raise no method error for unknown method" do
    expect {
      base.bar
    }.to raise_error(NoMethodError)
  end
end
