class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|

    	t.string :date_time
    	t.string :info_type
    	t.string :info_name
    	t.binary :info_value, :limit => 5.megabyte
      
      t.timestamps null: false

    end
  end
end
