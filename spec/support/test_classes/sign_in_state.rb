# frozen_string_literal: true

require_relative "./concerns/valid_credentials"
require_relative "./user"

class SignInState < Flow::StateBase
  include ValidCredentials

  option :email
  option :password

  output :auth_token

  validates :password, presence: true
  validates :user, presence: true

  def user
    User.find_by(email: email)&.authenticate(password) || nil if email.present? && password.present?
  end
  memoize :user
end
