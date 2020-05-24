# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can make a job offer' do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'and must fill in required fields' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit hunter_application_path application
      click_on I18n.t('views.navigation.offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.responsabilities'), with: '  '
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.blank'), count: 3
    end

    scenario 'and responsabilities and bonus must be at least 50 characters long' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit hunter_application_path application
      click_on I18n.t('views.navigation.offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.responsabilities'), with: 'a' * 49
      fill_in I18n.t('activerecord.attributes.job/application/offer.benefits'), with: 'a' * 49
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.too_short', count: 50), count: 2
    end

    scenario 'and expiration start must be valid' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit hunter_application_path application
      click_on I18n.t('views.navigation.offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.start_date'), with: 'dsa211$'
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n.t('errors.messages.invalid'), count: 1
    end

    scenario 'and expiration start must in the future' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit hunter_application_path application
      click_on I18n.t('views.navigation.offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.start_date'), with: 2.days.ago
      click_on I18n.t('views.actions.send')

      expect(page).to have_content I18n
        .t('activerecord.errors.models.job/application/offer.attributes.start_date.retroactive')
    end

    scenario 'and salary should be at least minimum wage' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      application = create :job_application, job: job_a, job_seeker: applicant

      visit hunter_application_path application
      click_on I18n.t('views.navigation.offer')

      fill_in I18n.t('activerecord.attributes.job/application/offer.salary'), with: 1038
      click_on I18n.t('views.actions.send')

      expect(page).to have_content(I18n.t('errors.messages.greater_than_or_equal_to', count: 1039))
    end
  end
end
