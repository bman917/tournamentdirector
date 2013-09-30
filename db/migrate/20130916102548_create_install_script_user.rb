class CreateInstallScriptUser < ActiveRecord::Migration
  def change
  	u = User.create(id: 1000, email: 'install_script', password: 'password', role: 'INSTALL_SCRIPT')
  	ActiveRecord::Base.connection.execute("update average_entries set user_id = 0 where user_id is null");
  end
end
