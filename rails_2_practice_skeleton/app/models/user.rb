class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true 
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}
    before_validation :ensure_session_token
    attr_reader :password 
    has_many :goals

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user 
        else
            nil
        end 
    end

    def self.generate_session_token 
        SecureRandom::urlsafe_base64
    end 

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end 

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end 

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end 

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end 
end
