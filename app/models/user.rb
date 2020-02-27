class User < ActiveRecord::Base
  has_many :articles
  before_save {self.email = email.downcase}
  validates :username, presence: true,
                        uniqueness: {case_sensitve: false},
                        length: {minimum: 3, maximum: 25}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                        uniqueness: {case_sensitve: false},
                        length: {minimum: 3, maximum: 105},
                        format: {with: VALID_EMAIL_REGEX}

  # user is present and unique
  # email is present and unique
  # valid email address
end
