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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require rails.validations
//= require popper
//= require bootstrap-sprockets
//= require active_storage_drag_and_drop
//= require jquery-easing/jquery.easing.min
//= require chart.js/Chart.min
//= require datatables/jquery.dataTables
//= require datatables/dataTables.bootstrap4
//= require jquery-fancytree/jquery.fancytree-all-deps.min
//= require jquery-fancytree/jquery.fancytree.table
//= require jquery-fancytree/jquery.fancytree.glyph
//= require jquery-fancytree/jquery.fancytree.wide
//= require jquery-fancytree/jquery.fancytree.dnd5
//= require x-editable/bootstrap-editable
//= require Chart.bundle
//= require chartkick
//= require_tree .

(function($) {
  "use strict"; // Start of use strict

  $(document).on('dnd-upload:initialize', 'input', function(e) {

    setTimeout(function() {
      $('#file-submit-button').click()      
    }, 1500);
    // 
    // console.log("YAAAAAY");
  });

  // Toggle the side navigation
  $(document).on('click',"#sidebarToggle",function(e) {
    e.preventDefault();
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
  });

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).on('scroll',function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    event.preventDefault();
  });

  $(document).on('shown.bs.modal', '#media-capsule-modal', function() {
    $('.modal-form').enableClientSideValidations();
  });

  $.fn.editable.defaults.mode = 'inline';
})(jQuery); // End of use strict
