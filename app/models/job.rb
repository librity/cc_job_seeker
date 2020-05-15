# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :head_hunter

  scope :by_head_hunter, ->(head_hunter) { where head_hunter: head_hunter }
end
