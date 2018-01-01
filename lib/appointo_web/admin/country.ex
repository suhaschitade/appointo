defmodule Appointo.ExAdmin.Country do
  use ExAdmin.Register

  register_resource Appointo.Countries.Country do
    index do
      selectable_column()

      column :id
      column :name
      actions()     # display the default actions column
    end
  end
end
