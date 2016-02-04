class User < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
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


    def follow(other_user)
      active_relationships.create(followed_id: other_user.id)
    end

    # Unfollows a user.
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # Returns true if the current user is following the other user.
    def following?(other_user)
      following.include?(other_user)
    end

    def feed
      following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
      Event.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
    end

	# Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
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

    def self.search(search)
      if search
        #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
        self.where("username like ?", "%#{search}%").limit(25)
      end
    end
end
