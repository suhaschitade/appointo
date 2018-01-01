defmodule Appointo.ExAdmin.User do
  use ExAdmin.Register

  register_resource Appointo.Accounts.User do
    index do
      selectable_column()

      column :id
      column :name
      actions()     # display the default actions column
    end
    form user do

      inputs "User Details" do
        input user, :name
        input user, :email
        input user, :password, type: :password
      end 
    end
  end
end
