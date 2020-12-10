$(function(){

$('#js-count').keyup(function(){
  var count = $(this).val().length;
  $('.show-count').text(count);
  });

});

window.onload = function() {
  const content = document.getElementById("js-count");
  const content_error_message = document.getElementById("content-error-message")
  const btn = document.getElementById("btn");
  btn.disabled = true;
  console.log(content);
  if(content){
    console.log(content);
    content.addEventListener("keyup", e => {
                console.log(content.value);
                if (content.value.length > 0 &&  content.value.length <= 140) {
                    content.setAttribute("class", "success");
                    content_error_message.style.display = "none";
                } else {
                    content.setAttribute("class", "error");
                    content_error_message.style.display = "inline";
                }
                console.log(content.getAttribute("class").includes("success"));
                checkSuccess();
            })
  }


  const checkSuccess = () => {
      if (content.value && content.getAttribute("class").includes("success")) {
          btn.disabled = false;
      } else {
          btn.disabled = true;
      }
  }
}
