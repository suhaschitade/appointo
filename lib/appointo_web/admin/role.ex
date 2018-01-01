defmodule Appointo.ExAdmin.Role do
  use ExAdmin.Register

  register_resource Appointo.Accounts.Role do
    index do
      selectable_column()

      column :id
      column :name
      actions()     # display the default actions column
    end
  end
end
