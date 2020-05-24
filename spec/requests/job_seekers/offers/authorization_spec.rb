# frozen_string_literal: true

require 'rails_helper'

describe 'Logged-out Job Seeker can browse job offers' do
  let!(:job_seeker) { log_job_seeker_in! }

  context 'tries to' do
    scenario 'patch a rejected offer' do
      application = create :job_application, job_seeker: job_seeker
      create :job_seeker_profile, job_seeker: job_seeker
      offer = create :job_application_offer, :accepted, application: application

      patch seeker_offer_reject_path(offer)

      expect(response).to redirect_to(seeker_offer_path(offer))
      follow_redirect!

      expect(response.body).to include(I18n.t('flash.closed_offer'))
    end

    scenario 'patch an accepted offer' do
      application = create :job_application, job_seeker: job_seeker
      create :job_seeker_profile, job_seeker: job_seeker
      offer = create :job_application_offer, :rejected, application: application

      patch seeker_offer_accept_path(offer)

      expect(response).to redirect_to(seeker_offer_path(offer))
      follow_redirect!

      expect(response.body).to include(I18n.t('flash.closed_offer'))
    end
  end
end
