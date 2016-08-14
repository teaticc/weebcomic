$(document).on("turbolinks:load", function(){
  selectToday();
  $(".tab__selector li").on("click",function(event){
    tabChange(event);
  });

});

// 今日のタブを選択
function selectToday(){
  var day_checker = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
  var today = new Date().getDay();
  var weekday = day_checker[today];
  // 取得した曜日タグとIDにselected付与
  $("li#" + weekday).addClass("selected");
  $("div." + weekday).addClass("selected");
}

// 選択されたタブを表示
function tabChange(event){
  $("li.selected").removeClass("selected");
  $(event.target).addClass("selected");
  $("div.wday-content").hide();
  $("div." + event.target.id).show();
}
