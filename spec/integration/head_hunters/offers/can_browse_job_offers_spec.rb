# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can browse job applications' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant
      offer = create :job_application_offer, :without_expectations, :without_bonus,
                     head_hunter: head_hunter, application: application

      visit hunter_application_path application

      expect(page).to have_content head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content I18n.l(offer.start_date)
      expect(page).to have_content number_to_currency(offer.salary)
      expect(page).to have_content offer.responsabilities
      expect(page).to have_content offer.benefits
      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content Job::Application::Offer.human_attribute_name("status.#{offer.status}")
      expect(page).to have_css('.ongoing_offer', count: 1)

      expect(page).not_to have_content I18n.t('activerecord.attributes.job/application/offer.expectations')
      expect(page).not_to have_content I18n.t('activerecord.attributes.job/application/offer.bonus')
      expect(page).not_to have_content I18n.t('activerecord.attributes.job/application/offer.feedback')
    end

    scenario 'and displays optional attributes' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant
      offer = create :job_application_offer, :with_feedback, head_hunter: head_hunter,
                                                             application: application

      visit hunter_application_path application

      expect(page).to have_content offer.expectations
      expect(page).to have_content offer.bonus
      expect(page).to have_content offer.feedback
    end

    scenario 'and changes css class when depending on status' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant
      offer = create :job_application_offer, :with_feedback,
                     head_hunter: head_hunter, application: application

      visit hunter_application_path application
      expect(page).to have_css('.ongoing_offer', count: 1)
      expect(page).to have_content offer.feedback

      offer.accepted!
      visit hunter_application_path application
      expect(page).to have_css('.accepted_offer', count: 1)
      expect(page).to have_content offer.feedback

      offer.rejected!
      visit hunter_application_path application
      expect(page).to have_css('.rejected_offer', count: 1)
      expect(page).to have_content offer.feedback
    end
  end
end
