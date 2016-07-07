window.addEventListener("load",function(){
  $("div.sun").addClass("selected");
  $("ul.tab-selector li").on("click",function(){
    $("li.selected").removeClass("selected");
    $(this).addClass("selected");
    $("div.wday_content").hide();
    $("div." + this.id).show();
  })
})