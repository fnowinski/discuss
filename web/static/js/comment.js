// import {Socket, Presence} from "phoenix"

// let socket = new Socket("/socket", {params: {token: window.userToken}})

// socket.connect()

// let channel = socket.channel("comment:lobby", {});
// let form = $("#comment-form");
// let comment = $("#comment-input");
// let commentContainer = document.getElementById("comments-container");

// comment.on("keypress", event => {
  // if(event.keyCode == 13) {
    // channel.push("comment:new", {comment: comment.val()})
    // comment.val("")
  // }
// });

// channel.on("comment:new", payload => {
  // let template = document.createElement("li");
  // template.className = "collection-item avatar";
  // template.innerHTML = `<img src="images/yuna.jpg" alt="" class="circle">
                        // <span class="title">${payload.comment}</span>
                        // <p>${payload.user}</p>
                        // <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>`

  // commentContainer.appendChild(template);
  // commentContainer.scrollTop = commentContainer.scrollHeight;
// });

// channel.join()
  // .receive("ok", resp => { console.log("Joined Comment Socket", resp) })
  // .receive("error", resp => { console.log("Unable to join", resp) })

// export default socket
