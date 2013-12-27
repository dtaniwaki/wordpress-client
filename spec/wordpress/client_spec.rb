require "spec_helper"
require 'faraday'
require 'wordpress/client'
require 'wordpress/request'

describe Wordpress::Client do
  subject :client do
    Wordpress::Client.new
  end

  context do
    it "should call get request" do
      req = Faraday::Request.new
      req.stub(:headers).and_return({})
      req.stub(:options).and_return({})
      req.should_receive(:url).with(anything)
      req.should_receive(:params=).with(anything)
      Faraday::Connection.any_instance.should_receive(:get).and_yield(req).and_return(Faraday::Response.new)
      Faraday::Response.any_instance.stub(:body).and_return('{}')

      request = Wordpress::Request.new(:get, 'url', {})
      client.call(request)
    end

    it "should call post request" do
      req = Faraday::Request.new
      req.stub(:headers).and_return({})
      req.stub(:options).and_return({})
      req.should_receive(:url).with(anything)
      req.should_receive(:params=).with(anything)
      req.should_receive(:body=).with(anything)
      Faraday::Connection.any_instance.should_receive(:post).and_yield(req).and_return(Faraday::Response.new)
      Faraday::Response.any_instance.stub(:body).and_return('{}')

      request = Wordpress::Request.new(:post, 'url', {}, {})
      client.call(request)
    end
  end

  context "with bearer_token_request option" do
    it "should call get request with Authorization header" do
      req = Faraday::Request.new
      req.stub(:headers).and_return({})
      req.headers.should_receive(:[]=).with('Authorization', 'Bearer something').once
      req.headers.should_receive(:[]=).with(any_args).at_least(:once)
      req.stub(:options).and_return({})
      req.should_receive(:url).with(anything)
      req.should_receive(:params=).with(anything)
      Faraday::Connection.any_instance.should_receive(:get).and_yield(req).and_return(Faraday::Response.new)
      Faraday::Response.any_instance.stub(:body).and_return('{}')

      request = Wordpress::Request.new(:get, 'url', {})
      client.access_token = 'something'
      client.call(request, :bearer_token_request => true)
    end

    it "should call get request without Authorization header for no access_token" do
      req = Faraday::Request.new
      req.stub(:headers).and_return({})
      req.headers.should_not_receive(:[]=).with('Authorization', 'Bearer something')
      req.stub(:options).and_return({})
      req.should_receive(:url).with(anything)
      req.should_receive(:params=).with(anything)
      Faraday::Connection.any_instance.should_receive(:get).and_yield(req).and_return(Faraday::Response.new)
      Faraday::Response.any_instance.stub(:body).and_return('{}')

      request = Wordpress::Request.new(:get, 'url', {})
      client.call(request, :bearer_token_request => true)
    end
  end
end
