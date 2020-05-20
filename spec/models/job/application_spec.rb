# frozen_string_literal: true

require 'rails_helper'

describe Job::Application, type: :model do
  describe 'relationships' do
    it { should respond_to(:job_seeker) }
    it { should respond_to(:job) }
  end

  let(:subject) { create :job_application }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: job' do
    it 'cannot be blank' do
      subject.job = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:job]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: job_seeker' do
    it 'cannot be blank' do
      subject.job_seeker = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:job_seeker]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: cover_letter' do
    it 'cannot be blank' do
      subject.cover_letter = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:cover_letter]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must have at least 50 characters' do
      subject.cover_letter = 'a' * 49

      expect(subject).to_not be_valid
      expect(subject.errors[:cover_letter]).to include(I18n.t('errors.messages.too_short', count: 50))
    end
  end

  context 'validation: rejection_feedback' do
    it 'can be null' do
      subject.rejection_feedback = nil

      expect(subject).to be_valid
    end

    it 'must have at least 50 characters' do
      subject.rejection_feedback = 'a' * 49

      expect(subject).to_not be_valid
      expect(subject.errors[:rejection_feedback]).to include(I18n.t('errors.messages.too_short', count: 50))
    end
  end

  context 'validation: standout' do
    it 'shoud default to false' do
      expect(subject.standout).to eq false
    end
  end

  context 'method: rejected?' do
    it 'shoud return true if rejection_feedback is present' do
      subject = create :job_application, :rejected

      expect(subject.rejected?).to eq true
    end

    it 'shoud return false otherwise' do
      expect(subject.rejected?).to eq false
    end
  end
end
