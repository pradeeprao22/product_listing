class User < ActiveRecord::Base
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
             foreign_key: "follower_id",
             dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
             foreign_key: "followed_id",
             dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save {self.email = email.downcase}
    before_create :create_activation_digest
    validates :username,  presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}

    has_secure_password

    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remember a user in the database for use in persistent session
    def remember
      self.remember_token = User.new_token
         update_attribute(:remember_digest, User.digest(remember_token))
    end

    #Return true if given token matches the digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    # User feed
    def feed
        following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
    end

    #Follows a user
    def follow(other_user)
        following << other_user
    end

    #Unfollow a user
    def unfollow(other_user)
        following.delete(other_user)
    end

    # Returns true if the current user is following the other user
    def following?(other_user)
        following.include?(other_user)
    end

    #Sets the password reset attributes
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    #Activates an account
    def activate
        update_columns(activated: FILL_IN, activated_at: FILL_IN)
    end

    # Sends Activation email
    def send_activation_email
       UserMailer.account_activation(self).deliver_now
    end

  private
    #converst email to a lower case
    def downcase_email
        self.email = email.downcase
    end

    #Creates and assigns the activation token and digest
  def create_activation_digest
      self.activation_token = User.new_token
      self.activation_token = User.digest(activation_token)
  end

end