# frozen_string_literal: true

module HeadHunters
  class RegistrationsController < Devise::RegistrationsController
    include Accessible
    skip_before_action :check_user, except: %i[new create]

  end
end
