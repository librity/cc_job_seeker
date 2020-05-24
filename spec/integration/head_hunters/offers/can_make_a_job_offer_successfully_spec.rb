# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can make a job offer' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant
      prototype_offer = build :job_application_offer

      visit hunter_application_path application
      click_on I18n.t('views.navigation.offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.start_date'),
              with: prototype_offer.start_date
      fill_in I18n.t('activerecord.attributes.job/application/offer.salary'),
              with: prototype_offer.salary
      fill_in I18n.t('activerecord.attributes.job/application/offer.responsabilities'),
              with: prototype_offer.responsabilities
      fill_in I18n.t('activerecord.attributes.job/application/offer.benefits'),
              with: prototype_offer.benefits
      fill_in I18n.t('activerecord.attributes.job/application/offer.expectations'),
              with: prototype_offer.expectations
      fill_in I18n.t('activerecord.attributes.job/application/offer.bonus'),
              with: prototype_offer.bonus
      click_on I18n.t('views.actions.send')

      expect(Job::Application::Offer.count).to eq 1
      offer = Job::Application::Offer.last

      expect(current_path).to eq hunter_offer_path offer
      expect(page).to have_content I18n.t('flash.created',
                                          resource: I18n.t('activerecord.models.job/application/offer.one'))
      expect(page).to have_content applicant.resolve_name
      expect(page).to have_content I18n.l(offer.created_at, format: :long)
      expect(page).to have_content I18n.l(prototype_offer.start_date)
      expect(page).to have_content number_to_currency(prototype_offer.salary)
      expect(page).to have_content prototype_offer.responsabilities
      expect(page).to have_content prototype_offer.benefits
      expect(page).to have_content prototype_offer.expectations
      expect(page).to have_content prototype_offer.bonus
      expect(page).to have_content Job::Application::Offer.human_attribute_name("status.#{offer.status}")
      expect(page).to have_content I18n.t('activerecord.attributes.job/application/offer/status.ongoing')
      expect(page).to have_css('.ongoing_offer', count: 1)
    end
  end
end
