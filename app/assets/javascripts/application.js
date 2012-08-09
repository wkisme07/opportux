// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.facebox
//= require autocomplete-rails
//= require pin_it
//= require_tree .

$(document).ready(function(){
  if($.fn.facebox) $('a[rel*=facebox]').facebox();

  if($.fn.chosen){
    $('.chzn-select').chosen({
      no_results_text: "No results matched for"
    });
  }

  if($.fn.validate){
    $("form").validate();
  }

  if($.fn.wysiwyg){
    $('.wysiwyg').wysiwyg({
      css: '/assets/application.css',
      initialContent: '',
      removeHeadings: true,
      controls: {
        insertImage: { visible: false },
        subscript: { visible: false },
        superscript: { visible: false },
        insertTable: { visible: false },
        h1: { visible: false },
        h2: { visible: false },
        h3: { visible: false }
      },
      plugins:{
        autoload: true,
        rmFormat:{
          rmMsWordMarkup: true
        }
      }
    });
  }

  // Main Search
  $('.header-search').click(function(){
    $('.search-form-container').slideToggle();
  });

  // User Menu
  $('#umenu-link > span').click(function(event){
    event.preventDefault();
    if ($('.hmenu-container').is(':visible')){
      $('.hmenu-container').slideUp();
      $(this).removeClass('active');
    }else{
      $('.hmenu-container').slideDown();
      $(this).addClass('active');
    }
  });
  $('html').click(function(event){
    target = $(event.target);
    target_id = target.attr('id');
    target_class = target.attr('class');

    if(target_id != 'umenu-link' && target_id != 'hmenu-container' &&
       target_id != 'umenu-avtr' && target_id != 'umenu-name' && target_id != 'umenu-arrow'){
      $('#umenu-link').removeClass('active');
      $('.hmenu-container').slideUp();
    }
  });

  // home flash message
  if($('.home-message-container').length){
    $('.home-message-container').slideDown();

    setTimeout(function(){
      $('.home-message-container').slideUp();

      setTimeout(function(){
        $('.home-message-container').remove();
      }, 2000);
    }, 5000);
  }

  // detail tab link
  $('.detail-info-tab ul li a').click(function(event){
    event.preventDefault();

    // active tab
    if (!$(this).hasClass('active')){
      $('.detail-info-tab ul li a').removeClass('active');
      $(this).addClass('active');
    }

    // hide all info
    $('.detail-info').children().hide();

    elid = $(this).attr('id');
    dcon = $('#detail-'+elid);
    if (dcon.length){
      dcon.show();
    }else{
      $.ajax({
        url: $(this).attr('href'),
        dataType: 'script'
      });
    }
  });

  // file field
  $('.file-field').change(function(event){
    file_val = $(this).val();
    $(this).parent().children('.fake-file-input').val(file_val);
  });

});


$.extend($.facebox.settings, {
  modal : true
});
$(document).bind('loading.facebox', function(){
  $("#facebox_overlay").unbind("click").click(function(){
    if (!$.facebox.settings.modal){
      $(document).trigger('close.facebox');
    }
  })
});



function remove_fields(link){
  var img_count = $('.image-group:visible').size() - 1;

  $(link).prev("input[type=hidden]").val("1");
  $(link).parent().parent().hide();
}

function add_fields(link, association, content){
  var img_count = $('.image-group:visible').size() + 1;

  if (img_count < 6){
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).before(content.replace(regexp, new_id));
  }else{
    alert('Five (5) images maximum per upload.');
  }
}

