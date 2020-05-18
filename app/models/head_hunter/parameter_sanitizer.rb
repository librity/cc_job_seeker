# frozen_string_literal: true

class HeadHunter
  class ParameterSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      permit :sign_up, keys: %i[name avatar social_name email
                                password password_confirmation]
    end
  end
end
