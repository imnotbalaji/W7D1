# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    before_validation :ensure_session_token

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :password_digest, presence: true


    # FIGVAPEBR
        # Find by 
        # Is_password?
        # Generate_session_token
        # Validations
        # Attr_reader
        # Password_digest
        # Ensure_session_token
        # Before_validation
        # Reset_session_token
    attr_reader :password

    def self.find_by_credentials(username, password)
        # '@' may not be necessary
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end

    end

    has_many :cats,
        primary_key: :id,
        foreign_key: :owner_id,
        class_name: :Cat,
        inverse_of: :owner,
        dependent: :destroy

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end


    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    private
    def generate_session_token
        SecureRandom::urlsafe_base64
    end
end
