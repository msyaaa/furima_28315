import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var moment = require('moment-timezone');
    let date = moment(data.date);
    date.locale('ja');
    date.tz('Asia/Tokyo');
    const day = date.fromNow();
    const html = `
      <div id="comment-set">
        <p>${data.user}</p>
        <div id="comments-frame">
          <p id="comments-comment">${data.content.text}</p>
          <p id="comment-time">
            <i class="far fa-clock", id="clock"></i>${day}
          </p>
        </div>
      </div>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');

    comments.insertAdjacentHTML('beforeend', html);
    newComment.value='';
    const error = document.getElementsByClassName('error-alert')
    // error.remove();
    while (error.length) {
      error.item(0).remove()
    }
    document.getElementById("submit-btn").removeAttribute("disabled");
  }
});
