# frozen_string_literal: true

require 'rails_helper'

describe 'Logged-in Head Hunter' do
  let!(:head_hunter) { log_head_hunter_in! }

  context 'comments on a profile' do
    scenario "and profile doesn't exist" do
      applicant = create :job_seeker

      post hunter_applicant_comment_path applicant

      expect(response).to redirect_to hunter_applicants_path
      follow_redirect!

      expect(response.body).to include(I18n.t('flash.profile_not_found'))
    end
  end
end
