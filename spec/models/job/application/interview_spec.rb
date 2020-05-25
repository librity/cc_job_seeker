# frozen_string_literal: true

require 'rails_helper'

describe Job::Application::Interview, type: :model do
  let(:subject) { create :job_application_interview }

  it 'has relations' do
    expect(subject).to respond_to(:application)
    expect(subject).to respond_to(:head_hunter)
    expect(subject).to respond_to(:job_seeker)
    expect(subject).to respond_to(:job)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: application' do
    it 'cannot be blank' do
      subject.application = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:application]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: head_hunter' do
    it 'cannot be blank' do
      subject.head_hunter = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:head_hunter]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: date' do
    it 'cannot be blank' do
      subject.date = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be a valid Time' do
      subject.date = '123123'

      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include(I18n.t('errors.messages.invalid'))
    end

    it 'must be in the future' do
      subject.date = 1.hour.ago

      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include(I18n
        .t('activerecord.errors.models.job/application/interview.attributes.date.retroactive'))
    end
  end

  context 'validation: address' do
    it 'cannot be blank' do
      subject.address = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:address]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: public_feedback' do
    it 'should default to false' do
      expect(subject.public_feedback).to eq false
    end
  end

  context 'validation: occurred' do
    it 'should default to nil' do
      expect(subject.occurred).to eq nil
    end
  end
end
