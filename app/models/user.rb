class User < ActiveRecord::Base
    has_many :games, through: :vacancies, dependent: :destroy
    has_many :vacancies, dependent: :destroy
    has_many :comments, through: :blogs, as: :pcomment
    has_many :comments, through: :games, as: :pcomment
    has_many :blogs
    
    attr_accessor :activation_token, :remember_token, :reset_token
    
    has_secure_password
    before_create :create_activation_digest
    
    validates :name, presence: true, length: {in: 3..30}, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 7,
         message: 'Enter password greater than 7 characters'}
    
    def self.digest(random_string)
      BCrypt::Password.create(random_string)    
    end
    
    def self.token
      SecureRandom.base64
    end
    
    def authenticated?(token, type)
      case type
      when 'remember'
        digest = self.remember_digest
      when 'activation'
        digest = self.activation_digest
      when 'reset'
        digest = self.reset_digest
      else
        return false
      end
      BCrypt::Password.new(digest).is_password?(token)
    end
#-----------------------------------------------------------------------------
    
    def remember
      self.remember_token = User.token
      update_columns(remember_digest: User.digest(remember_token))
    end
    
    def forget 
      self.remember_digest = nil
    end
        
#-----------------------------------------------------------------------------    
    
    def create_reset_password_digest
      self.reset_token = User.token
      update_columns(reset_digest: User.digest(reset_token), reset_password_at: Time.zone.now)
    end
    
    def send_reset_password_digest
      UserMailer.password_reset(self).deliver_now
    end

    def reset_passsword_is_over?
      reset_password_at < 1.hour.ago
    end

#-----------------------------------------------------------------------------    

    def send_activation_token_to_email
      UserMailer.account_activation(self).deliver_now
      update_attributes(send_activation_token_at: Time.zone.now, provider: 'local')
    end
    
    def activate
      update_columns(activated: true, activated_at: Time.zone.now)
      #update_column(:activated, true)
      #update_column(:activated_at, Time.zone.now)
    end

    def over_time_activated?
      send_activation_token_at < 1.hour.ago
    end
      
#------------------------------------------------------------------------------
    def self.create_omniauth_account(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        if !auth.info.email
          user.email = auth.uid + auth.provider + '.info'
        else
          user.email = auth.info.email
        end
          user.name = auth.info.name + "_from_" + auth.provider
          user.password = User.token
          user.image = auth.info.image if auth.info.image
          user.provider = auth.provider
      end
    end
    
    def create_image(uploaded_io)
      FileUtils.mkdir_p(File.join(Rails.root, 'public', 'uploads',
        "#{self.id}"))
        File.open(Rails.root.join('public', 'uploads', "#{self.id}",
        uploaded_io.original_filename),
        'wb') do |file|
          file.write(uploaded_io.read)
        end
      image = "/uploads/#{self.id}/#{uploaded_io.original_filename}"
      update_columns(image: image)
    end
    
    
    protected
    
    def create_activation_digest
      self.activation_token = User.token
      self.activation_digest = User.digest(activation_token)
    end
end

