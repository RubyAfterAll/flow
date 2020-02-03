# frozen_string_literal: true

class CreateAuthToken < Flow::OperationBase
  state_reader :user

  state_writer :auth_token

  failure :invalid_user, unless: -> { user.respond_to?(:id) && user.id.present? }

  def behavior
    state.auth_token = "trust_me.#{user.id}"
  end
end
