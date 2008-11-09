module PostRank
  class User
    attr_reader :email, :id
    
    def self.current
      info = JSON.parse(Connection.instance.get('/user/info.js'))
      User.new(info['user']['user_hash'], info['user']['email'])
    end

    def to_s
      @id
    end
    
    private
    
    def initialize(id, email)
      @id = id
      @email = email
    end
  end
end