// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

import {Socket, Presence} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("room", {});
let message = $('#message-input');
let chatMessages = document.getElementById("chat-messages");
let presences = {};
let onlineUsers = document.getElementById("online-users");

let listUsers = (user) => {
  return { user: user }
}

let renderUsers = (presences) => {
  onlineUsers.innerHTML = Presence.list(presences, listUsers)
    .map(presence => `
      <li>${presence.user}</li>`).join("")
}

message.focus();

message.on('keypress', event => {
  if(event.keyCode == 13) {
    channel.push('message:new', {message: message.val()})
    message.val("")
  }
});

channel.on('message:new', payload => {
  let template = document.createElement("div");
  template.innerHTML = `<b>${payload.user}</b>:
                               ${payload.message}<br>`
  chatMessages.appendChild(template);
  chatMessages.scrollTop = chatMessages.scrollHeight;
});

channel.on('presence_state', state => {
  presences = Presence.syncState(presences, state)
  renderUsers(presences)
});

channel.on('presence_diff', diff => {
  presences = Presence.syncDiff(presences, diff)
  renderUsers(presences)
});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket