require "spec_helper"
require 'wordpress/object/meta_object'

describe Wordpress::Object::MetaObject do
  subject { Wordpress::Object::MetaObject.new }
  describe "#save" do
    it "raise NotImplementedError" do
      proc {
        subject.save
      }.should raise_error(NotImplementedError)
    end
  end
  describe "#delete" do
    it "raise NotImplementedError" do
      proc {
        subject.delete
      }.should raise_error(NotImplementedError)
    end
  end
end
