# frozen_string_literal: true

require "active_model/secure_password"

require_relative "./concerns/valid_credentials"

class User < ActiveRecord::Base
  include ValidCredentials

  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email?
  end
end
