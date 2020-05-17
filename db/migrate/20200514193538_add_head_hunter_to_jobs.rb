

class AddHeadHunterToJobs < ActiveRecord::Migration[6.0]
  def change
    add_reference :jobs, :head_hunter, null: true, foreign_key: true
  end
end
