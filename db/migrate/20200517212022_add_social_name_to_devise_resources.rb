class AddSocialNameToDeviseResources < ActiveRecord::Migration[6.0]
  def change
    add_column :head_hunters, :social_name, :string
    add_column :job_seekers, :social_name, :string 

    add_index :head_hunters, :social_name, unique: false
    add_index :job_seekers, :social_name, unique: false
  end
end
