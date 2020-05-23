# frozen_string_literal: true

require 'rails_helper'

feature "Job Seeker can browse their application's" do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'related job offers' do
      job_a = create :job
      application = create :job_application, job: job_a, job_seeker: job_seeker
      offer_a = create :job_application_offer,
                       application: application,
                       created_at: 1.hour.ago,
                       start_date: 1.day.from_now
      offer_b = create :job_application_offer,
                       application: application,
                       created_at: 2.hour.ago,
                       start_date: 2.day.from_now

      offer_c = create :job_application_offer, created_at: 3.hour.ago,
                                               start_date: 3.day.from_now

      visit job_seekers_applications_path
      within "tr#application-#{application.id}" do
        click_on I18n.t('views.navigation.details')
      end

      expect(current_path).to eq job_seekers_application_path(application)
      expect(page).to have_content offer_a.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer_a.start_date)
      expect(page).to have_content I18n.l(offer_a.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer_a.salary)
      expect(page).to have_content offer_a.responsabilities
      expect(page).to have_content offer_a.benefits
      expect(page).to have_content offer_a.expectations
      expect(page).to have_content offer_a.bonus

      expect(page).to have_content offer_b.head_hunter.resolve_name
      expect(page).to have_content I18n.l(offer_b.start_date)
      expect(page).to have_content I18n.l(offer_b.created_at, format: :long)
      expect(page).to have_content number_to_currency(offer_b.salary)
      expect(page).to have_content offer_b.responsabilities
      expect(page).to have_content offer_b.benefits
      expect(page).to have_content offer_b.expectations
      expect(page).to have_content offer_b.bonus

      expect(page).not_to have_content offer_c.head_hunter.resolve_name
      expect(page).not_to have_content I18n.l(offer_c.start_date)
      expect(page).not_to have_content I18n.l(offer_c.created_at, format: :long)
      expect(page).not_to have_content number_to_currency(offer_c.salary)
      expect(page).not_to have_content offer_c.responsabilities
      expect(page).not_to have_content offer_c.benefits
      expect(page).not_to have_content offer_c.expectations
      expect(page).not_to have_content offer_c.bonus
    end
  end
end
