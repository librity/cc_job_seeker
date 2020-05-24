# frozen_string_literal: true

require 'rails_helper'

describe 'Logged-in Head Hunter' do
  let!(:head_hunter) { log_head_hunter_in! }

  context 'comments on a profile' do
    scenario "and profile doesn't exist" do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker

      post head_hunters_job_applicant_comment_path(job_a, applicant)

      expect(response).to redirect_to(head_hunters_job_path(job_a))
      follow_redirect!

      expect(response.body).to include(I18n.t('flash.profile_not_found'))
    end
  end
end
