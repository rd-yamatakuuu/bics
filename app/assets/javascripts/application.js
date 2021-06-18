// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery.raty.js

//= require rails-ujs
//= require activestorage
//= require_tree .

// ドロップダウンメニュー
$(function(){
  $('#navi').children('li').hover(function(){
    $(this).children('ul').stop().slideToggle(100);
  });
});


//review(viewpage)
$('.idea-review').raty({
  readOnly: true,
  score: function(){
    return $(this).attr('data-score');
  },
  path: '/assets/'
});

//home_about

$(function() {
  $('.slide-pic').slick({
    dots: true,
    autoplay: true,
    autoplaySpeed: 3000,
  });
});