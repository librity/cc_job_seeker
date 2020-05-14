# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :skills
      t.integer :salary_floor
      t.integer :salary_roof
      t.string :position
      t.string :location
      t.boolean :retired, default: false
      t.date :expires_on

      t.timestamps
    end
  end
end
