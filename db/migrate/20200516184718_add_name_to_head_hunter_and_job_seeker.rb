

class AddNameToHeadHunterAndJobSeeker < ActiveRecord::Migration[6.0]
  def change
    add_column :head_hunters, :name, :string, null: false, default: 'Jesse Smith'
    add_column :job_seekers, :name, :string, null: false, default: 'Jesse Smith'

    add_index :head_hunters, :name, unique: false
    add_index :job_seekers, :name, unique: false
  end
end
