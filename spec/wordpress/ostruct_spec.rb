require "spec_helper"
require 'wordpress/ostruct'

describe Wordpress::OpenStruct do
  it 'should generate accessor method at initialization'  do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.should respond_to :a
    o.should_not respond_to :b
  end

  it 'should not respond to unknown keys' do
    o = Wordpress::OpenStruct.new({})
    o.should_not respond_to :a
    expect {
      o.a = 1
    }.to raise_error(NoMethodError)
  end

  it 'should work with accessor' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.a.should == 1
    o.a = 2
    o.a.should == 2
  end

  it 'should parse hash recursively' do
    o = Wordpress::OpenStruct.new({:a => {:b => {:c => :d}}})
    o.a.should be_an(Wordpress::OpenStruct)
    o.a.b.should be_an(Wordpress::OpenStruct)
    o.a.b.c.should == :d
  end
end
