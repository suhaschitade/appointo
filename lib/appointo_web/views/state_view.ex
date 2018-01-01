defmodule AppointoWeb.StateView do
  use AppointoWeb, :view
  alias AppointoWeb.StateView

  def render("index.json", %{states: states}) do
    %{data: render_many(states, StateView, "state.json")}
  end

  def render("show.json", %{state: state}) do
    %{data: render_one(state, StateView, "state.json")}
  end

  def render("state.json", %{state: state}) do
    %{id: state.id,
      name: state.name,
      twolettercode: state.twolettercode,
      threelettercode: state.threelettercode,
      active: state.active}
  end
end
