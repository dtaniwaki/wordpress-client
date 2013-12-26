require "spec_helper"
require 'wordpress/ostruct'

describe Wordpress::OpenStruct do
  it 'should not respond to known keys' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.should respond_to :a
  end

  it 'should not respond to unknown keys' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.should_not respond_to :b
    expect {
      o.b
    }.to raise_error(NoMethodError)
  end

  it 'should work with accessor' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.a.should == 1
    o.a = 2
    o.a.should == 2
  end

  it 'should work with []' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o[:a].should == 1
    o[:a] = 2
    o[:a].should == 2
    o['a'].should == 2
    o['a'] = 3
    o['a'].should == 3
  end

  it 'should parse hash recursively' do
    o = Wordpress::OpenStruct.new({:a => {:b => {:c => :d}}})
    o.a.should be_an(Wordpress::OpenStruct)
    o.a.b.should be_an(Wordpress::OpenStruct)
    o.a.b.c.should == :d
  end

  it 'should assign hash' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.a.should == 1
    o.assign({:a => 2})
    o.a.should == 2
  end

  it 'should return custom string for to_s method' do
    o = Wordpress::OpenStruct.new({:a => {:b => 1}})
    o.to_s.should == "#<Wordpress::OpenStruct a=#<Wordpress::OpenStruct b=1>>"
  end

  it 'should return original hash' do
    o = Wordpress::OpenStruct.new({:a => 1})
    o.to_hash.should == {'a' => 1}
  end
end
