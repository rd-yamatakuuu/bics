class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|

      t.string :room_name, default: 'notitle_room'

      t.timestamps
    end
  end
end
