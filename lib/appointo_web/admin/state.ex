defmodule Appointo.ExAdmin.State do
  use ExAdmin.Register

  register_resource Appointo.States.State do
    index do
      selectable_column()

      column :id
      column :name
      actions()     # display the default actions column
    end
  end
end
