require "spec_helper"
require 'wordpress/request'

describe Wordpress::Request do
  let :request do
    Wordpress::Request.new(:get, 'url')
  end

  it "should deep clone" do
    new_request = request.dup
    new_request.should_not equal request
    new_request.params.should_not equal request.params
    new_request.body.should_not equal request.body
  end
end
