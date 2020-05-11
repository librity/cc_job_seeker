# frozen_string_literal: true

require 'rails_helper'

feature 'Users views home page' do
  scenario 'when not logged in' do
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_link I18n.t('views.navigation.home')
    expect(page).to have_link href: root_path, count: 2

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_head_hunter_session_path
    # expect(page).not_to have_link I18n.t('views.actions.log_out'),
    #                               href: destroy_job_seeker_session_path

    expect(page).to have_link I18n.t('views.navigation.head_hunter.login'),
                              href: new_head_hunter_session_path
    expect(page).to have_link I18n.t('views.navigation.head_hunter.signup'),
                              href: new_head_hunter_registration_path
    # expect(page).to have_link I18n.t('views.navigation.job_seeker.login'),
    #                           href: new_job_seeker_session_path
    # expect(page).to have_link I18n.t('views.navigation.job_seeker.signup'),
    #                           href: new_job_seeker_registration_path

    expect(page).to have_content I18n.t('views.application_name')
    expect(page).to have_content I18n.t('views.greeting')

    expect(page).to have_content I18n.t('views.footer.message_1')
    expect(page).to have_link 'Luis Geniole', href: 'https://github.com/librity'
    expect(page).to have_content I18n.t('views.footer.message_2')
    expect(page).to have_link 'Treina Dev,', href: 'https://treinadev.com.br/'
    expect(page).to have_content I18n.t('views.footer.message_3')
    expect(page).to have_link 'Campus Code', href: 'https://www.campuscode.com.br/'

    expect(page).to have_link I18n.t('views.footer.original_repo'),
                              href: 'https://github.com/librity/campus_code_job_seeker_app'
  end

  scenario 'when logged in as a Head Hunter' do
    head_hunter = HeadHunter.create! email: 'test@test.com.br', password: '12345678'
    login_as head_hunter, scope: :head_hunter

    visit root_path

    expect(current_path).to eq head_hunters_dashboard_path
    expect(page).to have_link I18n.t('views.navigation.home')
    expect(page).to have_link href: root_path, count: 2

    expect(page).to have_link I18n.t('views.actions.log_out'),
                              href: destroy_head_hunter_session_path
    # expect(page).not_to have_link I18n.t('views.actions.log_out'),
    #                               href: destroy_job_seeker_session_path

    expect(page).not_to have_link I18n.t('views.navigation.head_hunter.login'),
                                  href: new_head_hunter_session_path
    expect(page).not_to have_link I18n.t('views.navigation.head_hunter.signup'),
                                  href: new_head_hunter_registration_path
    # expect(page).not_to have_link I18n.t('views.navigation.job_seeker.login'),
    #                               href: new_job_seeker_session_path
    # expect(page).not_to have_link I18n.t('views.navigation.job_seeker.signup'),
    #                               href: new_job_seeker_registration_path

    expect(page).to have_content I18n.t('views.head_hunter_dashboard.title')
    expect(page).to have_content I18n.t('views.head_hunter_dashboard.greeting')

    expect(page).to have_content I18n.t('views.footer.message_1')
    expect(page).to have_link 'Luis Geniole', href: 'https://github.com/librity'
    expect(page).to have_content I18n.t('views.footer.message_2')
    expect(page).to have_link 'Treina Dev,', href: 'https://treinadev.com.br/'
    expect(page).to have_content I18n.t('views.footer.message_3')
    expect(page).to have_link 'Campus Code', href: 'https://www.campuscode.com.br/'

    expect(page).to have_link I18n.t('views.footer.original_repo'),
                              href: 'https://github.com/librity/campus_code_job_seeker_app'
  end

  xscenario 'when logged in as a Job Seeker' do
    job_seeker = JobSeeker.create! email: 'test@test.com.br', password: '12345678'
    login_as job_seeker, scope: :job_seeker

    visit root_path

    expect(current_path).to eq job_seeker_dashboard_path
    expect(page).to have_link I18n.t('views.navigation.home')
    expect(page).to have_link href: root_path, count: 2

    # expect(page).to have_link I18n.t('views.actions.log_out'),
    #                           href: destroy_job_seeker_session_path
    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_head_hunter_session_path

    # expect(page).not_to have_link I18n.t('views.navigation.job_seeker.login'),
    #                               href: new_job_seeker_session_path
    # expect(page).not_to have_link I18n.t('views.navigation.job_seeker.signup'),
    #                               href: new_job_seeker_registration_path
    # expect(page).not_to have_link I18n.t('views.navigation.job_seeker.login'),
    #                               href: new_job_seeker_session_path
    # expect(page).not_to have_link I18n.t('views.navigation.job_seeker.signup'),
    #                               href: new_job_seeker_registration_path

    expect(page).to have_content I18n.t('views.job_seeker_dashboard')
    expect(page).to have_content I18n.t('views.job_seeker_greeting')

    expect(page).to have_content I18n.t('views.footer.message_1')
    expect(page).to have_link 'Luis Geniole', href: 'https://github.com/librity'
    expect(page).to have_content I18n.t('views.footer.message_2')
    expect(page).to have_link 'Treina Dev,', href: 'https://treinadev.com.br/'
    expect(page).to have_content I18n.t('views.footer.message_3')
    expect(page).to have_link 'Campus Code', href: 'https://www.campuscode.com.br/'

    expect(page).to have_link I18n.t('views.footer.original_repo'),
                              href: 'https://github.com/librity/campus_code_job_seeker_app'
  end
end
