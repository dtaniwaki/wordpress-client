require "spec_helper"

describe Wordpress do
  it "should return client instance" do
    Wordpress.client.should be_an_instance_of(Wordpress::Client)
  end
end
