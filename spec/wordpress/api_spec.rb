require "spec_helper"
require 'wordpress/api'

describe Wordpress::API do
  let :client do
    Wordpress::Client.new
  end

  describe "\#exec_api" do
    it "should raise error for error response" do
      client.stub(:call).and_return({'error' => 'something wrong!'})
      expect {
        client.exec_api(nil)
      }.to raise_error(Wordpress::ResponseError)
    end
  end

  {
    # Me
    'me' => {:args => [], :method => :get, :url => '/rest/v1/me', :response => Wordpress::Object::User},
    'get_my_likes' => {:args => [], :method => :get, :url => '/rest/v1/me/likes', :response => Wordpress::OpenStruct},
    # Posts
    'get_posts' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename/posts', :response => Wordpress::Object::Posts},
    'get_post' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1', :response => Wordpress::Object::Post},
    'update_post' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/1', :response => Wordpress::Object::Post},
    'get_post_by_slug' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/slug:1', :response => Wordpress::Object::Post},
    'create_post' => {:args => ['sitename', {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/new', :response => Wordpress::Object::Post},
    'delete_post' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/1/delete', :response => Wordpress::Object::Post},
    'get_likes' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/likes', :response => Wordpress::OpenStruct},
    'create_like' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/1/likes/new', :response => Wordpress::OpenStruct},
    'delete_like' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/1/likes/mine/delete', :response => Wordpress::OpenStruct},
    'get_like_status' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/likes/mine', :response => Wordpress::OpenStruct},
    'get_reblog_status' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/reblogs/mine', :response => Wordpress::OpenStruct},
    'create_reblog' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/1/reblogs/new', :response => Wordpress::OpenStruct},
    # Sites
    'get_site' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename', :response => Wordpress::Object::Site},
    # Comments
    'get_comments' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename/comments', :response => Wordpress::Object::Comments},
    'get_post_comments' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/posts/1/replies', :response => Wordpress::Object::Comments},
    'get_comment' => {:args => ['sitename', 1], :method => :get, :url => '/rest/v1/sites/sitename/comments/1', :response => Wordpress::Object::Comment},
    'update_comment' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/comments/1', :response => Wordpress::Object::Comment},
    'create_comment' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/posts/1/replies/new', :response => Wordpress::Object::Comment},
    'delete_comment' => {:args => ['sitename', 1, {}], :method => :post, :url => '/rest/v1/sites/sitename/comments/1/delete', :response => Wordpress::Object::Comment},
    # Tests
    'get_test' => {:args => [1], :method => :get, :url => '/rest/v1/test/1', :response => Wordpress::Object::Test},
    'post_test' => {:args => [1, {}], :method => :post, :url => '/rest/v1/test/1', :response => Wordpress::Object::Test},
    # Taxonomy
    'get_category' => {:args => ['sitename', 'cat_name'], :method => :get, :url => '/rest/v1/sites/sitename/categories/slug:cat_name', :response => Wordpress::OpenStruct},
    'update_category' => {:args => ['sitename', 'cat_name', {}], :method => :post, :url => '/rest/v1/sites/sitename/categories/slug:cat_name', :response => Wordpress::OpenStruct},
    'get_tag' => {:args => ['sitename', 'tag_name'], :method => :get, :url => '/rest/v1/sites/sitename/tags/slug:tag_name', :response => Wordpress::OpenStruct},
    'update_tag' => {:args => ['sitename', 'tag_name', {}], :method => :post, :url => '/rest/v1/sites/sitename/tags/slug:tag_name', :response => Wordpress::OpenStruct},
    'create_category' => {:args => ['sitename', {}], :method => :post, :url => '/rest/v1/sites/sitename/categories/new', :response => Wordpress::OpenStruct},
    'create_tag' => {:args => ['sitename', {}], :method => :post, :url => '/rest/v1/sites/sitename/tags/new', :response => Wordpress::OpenStruct},
    'delete_category' => {:args => ['sitename', 'cat_name', {}], :method => :post, :url => '/rest/v1/sites/sitename/categories/slug:cat_name/delete', :response => Wordpress::OpenStruct},
    'delete_tag' => {:args => ['sitename', 'tag_name', {}], :method => :post, :url => '/rest/v1/sites/sitename/tags/slug:tag_name/delete', :response => Wordpress::OpenStruct},
    # Follow
    'create_follow' => {:args => ['sitename', {}], :method => :post, :url => '/rest/v1/sites/sitename/follows/new', :response => Wordpress::OpenStruct},
    'delete_follow' => {:args => ['sitename', {}], :method => :post, :url => '/rest/v1/sites/sitename/follows/mine/delete', :response => Wordpress::OpenStruct},
    'get_follow' => {:args => ['sitename'], :method => :get, :url => '/rest/v1/sites/sitename/follows/mine', :response => Wordpress::OpenStruct},
    # FreshlyPressed
    'freshly_pressed' => {:method => :get, :url => '/rest/v1/freshly-pressed', :response => Wordpress::OpenStruct},
    # Notifications
    'get_notifications' => {:method => :get, :url => '/rest/v1/notifications', :response => Wordpress::OpenStruct},
    'get_notification' => {:args => [1], :method => :get, :url => '/rest/v1/notifications/1', :response => Wordpress::OpenStruct},
    'see_notifications' => {:args => [{}], :method => :post, :url => '/rest/v1/notifications/seen', :response => Wordpress::OpenStruct},
    'read_notifications' => {:args => [{}], :method => :post, :url => '/rest/v1/notifications/read', :response => Wordpress::OpenStruct},
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
