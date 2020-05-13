# frozen_string_literal: true

class HeadHunter < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :lockable, :timeoutable, :trackable
end