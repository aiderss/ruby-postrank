require 'oauth/consumer'
require 'singleton'

module PostRank
  class Connection
    include Singleton
    
    attr_accessor :appkey, :app_secret, :app_token, :user_secret, :user_token
    
    def initialize
      @access_token = nil
    end
    
    def authorization_url
      @request_token = consumer.get_request_token
      @request_token.authorize_url
    end
    
    def authorize      
      unless have_credentials?
        return false if @request_token.nil?
        
        @access_token = @request_token.get_access_token
        @request_token = nil
        
        @user_secret = @access_token.secret
        @user_token = @access_token.token
      else
        @access_token = OAuth::AccessToken.new(consumer, @user_token, @user_secret)
      end
      true
    end

    def get(url)
      check_access
      val = @access_token.get(url, {'User-Agent' => @appkey})
      
      # if the page is moved we'll return a request for the new page
      if val.is_a?(Net::HTTPMovedPermanently)
        return get(JSON.parse(val.body)['url'])
      end
      
      if val.is_a?(Net::HTTPInternalServerError) && val.body =~ /feed_not_in_database/
        raise UnknownFeedException.new
      end
      
      raise APIException.new("Unable to get #{url}: #{val.code}") unless val.is_a?(Net::HTTPOK)
      val.body
    end
  
    def post(url, data)
      check_access
      val = @access_token.post(url, data.to_json, {'Accept' => 'application/json',
                                                    'Content-Type' => 'application/json',
                                                    'User-Agent' => @appkey})
      raise APIException.new("Unable to post data: #{val.code}") unless val.is_a?(Net::HTTPCreated)
      val                                            
    end
  
    def delete(url)
      check_access
      val = @access_token.delete(url, {'User-Agent' => @appkey})
      raise APIException.new("Unable to delete: #{val.code}") unless val.is_a?(Net::HTTPOK)
      val
    end
  
    def put(url, data)
      check_access
      val = @access_token.put(url, data.to_json, {'Accept' => 'application/json',
                                                    'Content-Type' => 'application/json',
                                                    'User-Agent' => @appkey})
      raise APIException.new("Unable to put data: #{val.code}") unless val.is_a?(Net::HTTPOK)
      val                                     
    end

    private
    
    def consumer
      raise InvalidApplicationCredentialsException if @app_secret.nil? || @app_token.nil?
      OAuth::Consumer.new(@app_token, @app_secret, {:site => "http://www.postrank.com"})
    end

    def have_credentials?
      !(@user_token.nil? || @user_secret.nil? || @user_token =~ /^\s*$/ || @user_secret =~ /^\s*$/)
    end

    def authorized?
      !@access_token.nil?
    end
    
    def check_access
      raise CredentialsException.new("Credentials missing") unless have_credentials?
      authorize unless authorized?
      raise APIException.new("Unable to authenticate to PostRank") unless authorized?
    end
  end
end
