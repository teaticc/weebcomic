// window.addEventListener("load",function(){
//    // 曜日取得
//   var day_checker = new Array("sun", "mon", "tue", "wed", "thu", "fri", "sat");
//   var weekday = new Date().getDay();
//   var today = day_checker[weekday];
//   // 取得した曜日タグとIDにselected付与
//   $("li#" + today).addClass("selected");
//   $("div." + today).addClass("selected");
//   // タブクリックで選択曜日にslected付与
//   $("ul.tab-selector li").on("click",function(){
//     $("li.selected").removeClass("selected");
//     $(this).addClass("selected");
//     $("div.wday_content").hide();
//     $("div." + this.id).show();
//   });
// });
// var ready;
// ready =function(){
//    // 曜日取得
//   var day_checker = new Array("sun", "mon", "tue", "wed", "thu", "fri", "sat");
//   var weekday = new Date().getDay();
//   var today = day_checker[weekday];
//   // 取得した曜日タグとIDにselected付与
//   $("li#" + today).addClass("selected");
//   $("div." + today).addClass("selected");
//   // タブクリックで選択曜日にslected付与
//   $("ul.tab-selector li").on("click",function(){
//     $("li.selected").removeClass("selected");
//     $(this).addClass("selected");
//     $("div.wday_content").hide();
//     $("div." + this.id).show();
//   });
// };


$(document).on("turbolinks:load", function(){
  var day_checker = new Array("sun", "mon", "tue", "wed", "thu", "fri", "sat");
  var weekday = new Date().getDay();
  var today = day_checker[weekday];
  // 取得した曜日タグとIDにselected付与
  $("li#" + today).addClass("selected");
  $("div." + today).addClass("selected");
  // タブクリックで選択曜日にslected付与
  $("ul.tab-selector li").on("click",function(){
    $("li.selected").removeClass("selected");
    $(this).addClass("selected");
    $("div.wday_content").hide();
    $("div." + this.id).show();
  });
  // お気に入り解除ボタン
  $(document).on("click", "input.like.yes",function(){
    console.log(this);
    $(this).removeClass("yes");
    $("input.not_like#" + this.id).addClass("yes");
    $(this).hide();
    $("input.not_like.yes#" + this.id).show();
  });
  // お気に入りボタン
  $(document).on("click", "input.not_like.yes",function(){
    console.log(this);
    $(this).removeClass("yes");
    $("input.like#" + this.id).addClass("yes");
    $(this).hide();
    $("input.like.yes#" + this.id).show();
  });
});
