require "spec_helper"
require 'wordpress/api'

describe Wordpress::API do
  let :client do
    Wordpress::Client.new
  end

  # Get methods
  {
    'me' => {:args => [], :method => :get, :url => '/rest/v1/me', :response => Wordpress::Object::User},
    'get_my_likes' => {:args => [], :method => :get, :url => '/rest/v1/me/likes', :response => Wordpress::OpenStruct},
    'get_posts' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename/posts', :response => Wordpress::Object::Posts},
    'get_post' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1', :response => Wordpress::Object::Post},
    'get_post_by_slug' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/slug:1', :response => Wordpress::Object::Post},
    'get_likes' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/likes', :response => Wordpress::OpenStruct},
    'get_like_status' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/likes/mine', :response => Wordpress::OpenStruct},
    'get_reblog_status' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/reblogs/mine', :response => Wordpress::OpenStruct},
    'get_site' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename', :response => Wordpress::Object::Site},
    'get_comments' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename/comments', :response => Wordpress::Object::Comments},
    'get_post_comments' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/replies', :response => Wordpress::Object::Comments},
    'get_comment' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/comments/1', :response => Wordpress::Object::Comment},
    'get_test' => {:args => [1], :method => :get, :url => '/rest/v1/test/1', :response => Wordpress::Object::Test},
    'get_category' => {:args => ['sitename', 'cat_name'], :method => :get, :url => '/rest/v1/sites/sitename/categories/slug:cat_name', :response => Wordpress::OpenStruct},
    'get_tag' => {:args => ['sitename', 'tag_name'], :method => :get, :url => '/rest/v1/sites/sitename/tags/slug:tag_name', :response => Wordpress::OpenStruct},
    'get_follow' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename/follows/mine', :response => Wordpress::OpenStruct},
    'freshly_pressed' => {:method => :get, :url => '/rest/v1/freshly-pressed', :response => Wordpress::OpenStruct},
    'get_notifications' => {:method => :get, :url => '/rest/v1/notifications', :response => Wordpress::OpenStruct},
    'get_notification' => {:args => [1], :method => :get, :url => '/rest/v1/notifications/1', :response => Wordpress::OpenStruct},
  }.each do |method, params|
    describe "\##{method}" do
      it "should return #{params[:response].name}" do
        request = Wordpress::Request.new(params[:method], params[:url])
        client.stub(:call).and_return({})
        client.should_receive(:call).with do |*args|
          req = args.shift
          req.method.should == request.method
          req.url.should == request.url
        end
        obj = client.send(method, *params[:args])
        obj.should be_an(params[:response])
      end

      it "should raise error with invalid parameter" do
        expect {
          args = [method, *params[:args]]
          args << {:invalid_key => 1}
          obj = client.send(*args)
        }.to raise_error(Wordpress::ArgumentError)
      end
    end
  end
end
