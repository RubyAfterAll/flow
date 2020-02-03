# frozen_string_literal: true

require_relative "./concerns/valid_credentials"
require_relative "./user"
require_relative "./create_auth_token"
require_relative "./sign_in_state"

class SignInFlow < Flow::FlowBase
  operations CreateAuthToken
end
