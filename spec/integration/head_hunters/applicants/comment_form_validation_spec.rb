# frozen_string_literal: true

require 'rails_helper'

feature "Head Hunter can comment on an applicant's profile" do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'and must fill required fields' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

      fill_in I18n.t('views.job_seekers/profiles.comment'), with: '   '
      click_on I18n.t('views.actions.comment')

      expect(page).to have_content I18n.t('errors.messages.blank'), count: 1
    end

    scenario 'and content should be at least 50 characters long' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

      fill_in I18n.t('views.job_seekers/profiles.comment'), with: 'a' * 49
      click_on I18n.t('views.actions.comment')

      expect(page).to have_content I18n.t('errors.messages.too_short', count: 50)
    end
  end
end
