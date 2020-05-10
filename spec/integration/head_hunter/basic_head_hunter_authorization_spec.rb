# frozen_string_literal: true

require 'rails_helper'

feature 'User browses' do
  scenario "application and links to resources don't appear unless logged-in" do
    visit root_path

    expect(page).to have_link I18n.t('views.navigation.log_in')
    expect(page).not_to have_link I18n.t('views.actions.log_out')

    expect(page).not_to have_link I18n.t('activerecord.models.manufacturer.other')
    expect(page).not_to have_link I18n.t('activerecord.models.car_category.other')
    expect(page).not_to have_link I18n.t('activerecord.models.car_model.other')
    expect(page).not_to have_link I18n.t('activerecord.models.subsidiary.other')
    expect(page).not_to have_link I18n.t('activerecord.models.customer.other')
    expect(page).not_to have_link I18n.t('activerecord.models.rental.other')
    expect(page).not_to have_link I18n.t('activerecord.models.car.other')
  end

  scenario 'application and links to resources appear when logged-in' do
    user = User.create! email: 'test@test.com.br', password: '12345678'
    login_as user, scope: :user

    visit root_path

    expect(page).not_to have_link I18n.t('views.navigation.log_in')
    expect(page).to have_link I18n.t('views.actions.log_out')

    expect(page).to have_link I18n.t('activerecord.models.manufacturer.other')
    expect(page).to have_link I18n.t('activerecord.models.car_category.other')
    expect(page).to have_link I18n.t('activerecord.models.car_model.other')
    expect(page).to have_link I18n.t('activerecord.models.subsidiary.other')
    expect(page).to have_link I18n.t('activerecord.models.customer.other')
    expect(page).to have_link I18n.t('activerecord.models.rental.other')
    expect(page).to have_link I18n.t('activerecord.models.car.other')
  end

  context 'manufacturers' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit manufacturers_path
      expect(current_path).to eq manufacturers_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit manufacturers_path
      expect(current_path).to eq new_user_session_path

      visit new_manufacturer_path
      expect(current_path).to eq new_user_session_path

      page.driver.post manufacturers_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit manufacturer_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_manufacturer_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete manufacturer_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'car categories' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit car_categories_path
      expect(current_path).to eq car_categories_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit car_categories_path
      expect(current_path).to eq new_user_session_path

      visit new_car_category_path
      expect(current_path).to eq new_user_session_path

      page.driver.post car_categories_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit car_category_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_car_category_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete car_category_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'car models' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit car_models_path
      expect(current_path).to eq car_models_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit car_models_path
      expect(current_path).to eq new_user_session_path

      visit new_car_model_path
      expect(current_path).to eq new_user_session_path

      page.driver.post car_models_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit car_model_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_car_model_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete car_model_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'subsidiaries' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit subsidiaries_path
      expect(current_path).to eq subsidiaries_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit subsidiaries_path
      expect(current_path).to eq new_user_session_path

      visit new_subsidiary_path
      expect(current_path).to eq new_user_session_path

      page.driver.post subsidiaries_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit subsidiary_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_subsidiary_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete subsidiary_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'customers' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit customers_path
      expect(current_path).to eq customers_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit customers_path
      expect(current_path).to eq new_user_session_path

      visit new_customer_path
      expect(current_path).to eq new_user_session_path

      page.driver.post customers_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit customer_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_customer_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete customer_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'cars' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit cars_path
      expect(current_path).to eq cars_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit cars_path
      expect(current_path).to eq new_user_session_path

      visit new_car_path
      expect(current_path).to eq new_user_session_path

      page.driver.post cars_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit car_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_car_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete car_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'rentals' do
    scenario 'successfully' do
      user = User.create! email: 'test@test.com.br', password: '12345678'
      login_as user, scope: :user

      visit rentals_path
      expect(current_path).to eq rentals_path
    end

    scenario 'and gets redirected to log in view if not logged-in' do
      visit rentals_path
      expect(current_path).to eq new_user_session_path

      visit new_rental_path
      expect(current_path).to eq new_user_session_path

      page.driver.post rentals_path
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path

      visit rental_path(1)
      expect(current_path).to eq new_user_session_path

      visit edit_rental_path(1)
      expect(current_path).to eq new_user_session_path

      page.driver.delete rental_path(1)
      visit page.driver.response.location
      expect(current_path).to eq new_user_session_path
    end
  end
end
