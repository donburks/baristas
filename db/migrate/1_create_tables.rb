class CreateTables < ActiveRecord::Migration
	def change
		create_table :baristas do |t|
			t.string :name
			t.timestamps
		end

		create_table :coffees do |t|
			t.string :name
			t.references :barista
			t.timestamps
		end
	end
end
