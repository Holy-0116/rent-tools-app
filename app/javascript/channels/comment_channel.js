import consumer from "./consumer"


const aaa = consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
  
  received(data) {
    const html = `<li class="item-comment">
                     <div class="comment-user">
                       ${data.content[0].commenter} 
                    </div>
                    <div class="comment-body">
                      <div class="comment-text">
                           ${data.content[0].comment} 
                      </div>
                      <div class="comment-time">
                             ${data.content[0].date} 
                      </div> 
                    </div>
                  </li>`
    
    const comment = document.getElementById("comments");
    comment.insertAdjacentHTML('beforeend', html);
    const newComment = document.getElementById('comment_text');
    
    newComment.value='';
  }
});
