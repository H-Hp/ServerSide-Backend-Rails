class RenamePasswordToPasswordDigestInEsTests < ActiveRecord::Migration[6.1]
  def change
    rename_column :es_tests, :password, :password_digest
  end
end
