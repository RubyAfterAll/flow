# frozen_string_literal: true

module ValidCredentials
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true
    validates :email, format: %r{\A[^@\s]+@[^@\s]+\z}, if: -> { email.present? }
    validates :password, length: { minimum: 6, maximum: 20 }, if: -> { password.present? }
  end
end
