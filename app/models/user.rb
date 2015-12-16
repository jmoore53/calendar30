class User < ActiveRecord::Base
  has_many :events, dependent: :destroy
  extend FriendlyId
  friendly_id :username

	attr_accessor :remember_token

	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	before_save { self.email = email.downcase }

	validates :firstN, :lastN, presence: true, length: {minimum: 2, maximum: 64}
	validates :email, presence: true, uniqueness: true
	validates_format_of :email, with: VALID_EMAIL_REGEX, :on => :create

	#vaildates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
	#validates_confirmation_of :password, allow_blank: true

	validates :password, presence: true, confirmation: true, length: {minimum: 8, maximum: 64}, :on => :create
	validates :password_confirmation, presence: true
	
	validates :mobile_phone, format: { with: /\d{3}\d{3}\d{4}/, message: "is invalid" }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


	# Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

 	# Returns a random token.
  	def User.new_token
    	SecureRandom.urlsafe_base64
  	end

  	def remember
    	self.remember_token = User.new_token
   	 	update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	# Returns true if the given token matches the digest.
  	def authenticated?(remember_token)
  		return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

  	def forget
  		update_attribute(:remember_digest, nil);
  	end
end
