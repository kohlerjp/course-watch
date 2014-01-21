class User < ActiveRecord::Base
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  # always make sure it is downcase before a save
  before_save {self.email = self.email.downcase}
  before_save {self.first_name = self.first_name.downcase}
  before_save {self.last_name = self.last_name.downcase}
  before_create :create_remember_token
  validates :first_name, presence: true, length: {maximum:20}
  validates :last_name, presence: true, length: {maximum:20}
  # regex makes sure it is northeastern email address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@husky.neu.edu\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}, length: {maximum:30}
  validates :password, length: {minimum:6}
  has_secure_password

  # enroll this user in given course

  def enroll!(course_id)
    self.enrollments.create!(course_id:course_id)
  end

  def drop!(course_id)
    self.enrollments.find_by(course_id:course_id).destroy!
  end

  # generate ea new random remember_token
  def User.new_remember_token
  	return SecureRandom.urlsafe_base64
  end
  # encrypt a remember_me token
  def User.encrypt(token)
  	return Digest::SHA1.hexdigest(token.to_s)
  end


  private
  	# create remember me token for this user
  	def create_remember_token
  		self.remember_token = User.encrypt(User.new_remember_token)
  	end
end
