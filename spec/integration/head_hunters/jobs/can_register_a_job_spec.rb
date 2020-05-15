# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can register a job' do
  before :each do
    log_user_in!
  end

  xscenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')

    expect(page).to have_link I18n.t('views.navigation.new'), href: new_car_category_path
  end

  xscenario 'successfully' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Pickup'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: '120'
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: '30'
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: '40'
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq car_category_path(CarCategory.last.id)
    expect(page).to have_content I18n.t('views.messages.successfully.created',
                                        resource: I18n.t('activerecord.models.car_category.one'))
    expect(page).to have_content 'Pickup'
    expect(page).to have_content 'R$ 120'
    expect(page).to have_content 'R$ 30'
    expect(page).to have_content 'R$ 40'
    expect(page).to have_link I18n.t('views.navigation.go_back'), href: car_categories_path
  end

  xscenario 'and name must be unique' do
    CarCategory.create! name: 'Sedan', daily_rate: 100.0, insurance: 10.0,
                        third_party_insurance: 5.0

    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end

  xscenario 'and name can not be blank' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  xscenario 'and daily rate should be greater than zero' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: -2.4
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: 123.5
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: 28.5
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than', count: 0))
  end

  xscenario 'and insurance should be greater than zero' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: 123.5
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: -2.4
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: 28.5
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than', count: 0))
  end

  xscenario 'and third party insurance should be greater than zero' do
    visit root_path
    click_on  I18n.t('activerecord.models.car_category.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Sedan'
    fill_in I18n.t('activerecord.attributes.car_category.daily_rate'), with: 28.5
    fill_in I18n.t('activerecord.attributes.car_category.insurance'), with: 123.5
    fill_in I18n.t('activerecord.attributes.car_category.third_party_insurance'), with: -2.4
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than', count: 0))
  end
end
