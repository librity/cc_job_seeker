# frozen_string_literal: true

require 'rails_helper'

feature "Head Hunter can browse comments on an applicant's profile" do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      profile = create :job_seeker_profile, job_seeker: applicant
      comments = create_list :job_seeker_profile_comment, 5, profile: profile
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

      expect(page).to have_content I18n.t('activerecord.models.job_seeker/profile/comment.other')

      comments.each do |comment|
        expect(page).to have_content comment.content
        expect(page).to have_content I18n.l(comment.created_at, format: :long)
        expect(page).to have_content comment.head_hunter.resolve_name
      end
    end

    scenario 'and job has no applications' do
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

      expect(page).to have_content I18n.t('views.job_seekers/profiles/comments.empty_resource')
    end
  end
end
