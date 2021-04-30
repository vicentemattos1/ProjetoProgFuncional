defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="post">
      <div class="row">
      <img alt="Qries" width=50 height=50 style="border-radius:50%" src="https://media-exp1.licdn.com/dms/image/C4D03AQGv9ouOmGy1cw/profile-displayphoto-shrink_200_200/0/1614004824536?e=1625097600&v=beta&t=9lScLcQSnG47MzQizE5OdaGeWXOtineJJkyffAXjYi0"
      onclick="document.location.href='https://media-exp1.licdn.com/dms/image/C4D03AQGv9ouOmGy1cw/profile-displayphoto-shrink_200_200/0/1614004824536?e=1625097600&v=beta&t=9lScLcQSnG47MzQizE5OdaGeWXOtineJJkyffAXjYi0'">
        <div class="column column-90 post-body">
          <b>@<%= @post.username %></b>
          <br/>
          <%= @post.body %>
        </div>
      </div>

      <div class="row">
        <div class="column post-button-column">
          <a href="#" phx-click="like" phx-target="<%= @myself %>">
          <i class="far fa-heart"></i> <%= @post.likes_count %>
        </div>
        <div class="column post-button-column">
          <a href="#" phx-click="repost" phx-target="<%= @myself %>">
          <i class="far fa-hand-peace"></i> <%= @post.reposts_count %>
        </div>
        <div class="column post-button-column">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <i class="far fa-edit"></i>
          <% end %>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id do %>
            <i class="far fa-trash-alt"></i>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
