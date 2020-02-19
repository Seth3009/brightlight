class CreateTablefuncExtension < ActiveRecord::Migration
  def up
    execute <<-SQL
              CREATE extension IF NOT EXISTS tablefunc;
            SQL
  end

  def down
    execute <<-SQL
              DROP extension IF EXISTS tablefunc;
            SQL
  end
end
