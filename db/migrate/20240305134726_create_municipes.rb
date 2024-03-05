class CreateMunicipes < ActiveRecord::Migration[7.1]
  def change
    create_table :municipes do |t|
      t.string :full_name
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :birth
      t.string :phone
      t.string :photo
      t.string :status

      t.timestamps
    end
  end
end
