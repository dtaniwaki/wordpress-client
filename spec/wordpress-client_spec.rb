require "spec_helper"

describe Wordpress do
  describe "client" do
    it "should return client instance" do
      Wordpress.client.should be_an_instance_of(Wordpress::Client)
    end

    it "should return the same instance" do
      client = Wordpress.client
      Wordpress.client.should === client
    end
  end

  describe "logger" do
    it "should have default logger" do
      Wordpress.logger.should be_an(Logger)
    end

    it "should have accessor" do
      Wordpress.logger = 'logger'
      Wordpress.logger.should == 'logger'
    end
  end
end
