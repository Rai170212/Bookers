class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      # 本のタイトルを保存するカラム
      t.string :title
      # 本の感想
      t.text :body

      t.timestamps
    end
  end
end
