class AddQyWechatColumnsTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table(:<%= table_name %>) do |t|
      t.string :qy_token
      t.string :encoding_aes_key
      t.string :corp_id
      t.string :qy_secret_key
    end
    add_index :<%= table_name %>, :qy_token
    add_index :<%= table_name %>, :encoding_aes_key
    add_index :<%= table_name %>, :corp_id
    add_index :<%= table_name %>, :qy_secret_key
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
