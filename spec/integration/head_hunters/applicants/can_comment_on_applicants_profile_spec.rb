# frozen_string_literal: true

require 'rails_helper'

feature "Head Hunter can comment on an applicant's profile" do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job_a, job_seeker: applicant

      prototype_comment = build :job_seeker_profile_comment

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

      fill_in I18n.t('views.job_seekers/profiles.comment'), with: prototype_comment.content
      click_on I18n.t('views.actions.comment')

      expect(JobSeeker::Profile::Comment.count).to eq 1
      comment = JobSeeker::Profile::Comment.last
      expect(current_path).to eq hunter_applicant_path(applicant)
      expect(page).to have_content comment.content
      expect(page).to have_content I18n.l(comment.created_at, format: :long)
      expect(page).to have_content head_hunter.resolve_name
    end
  end
end
