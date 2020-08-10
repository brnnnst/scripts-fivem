$(function() {
	init();
  
	var actionContainer = $("#actionmenu");

	window.addEventListener('message',function(event){
		var item = event.data;

		if (item.showmenu){
			ResetMenu()
			actionContainer.show();
		}

		if (item.hidemenu){
			actionContainer.hide();
		}
	});
  

  });
  
  function ResetMenu() {
	$("div").each(function(i, obj) {
	  var element = $(this);
  
	  if (element.attr("data-parent")) {
		element.hide();
	  } else {
		element.show();
	  }
	});
  }
  
  function init() {
	$(".menuoption").each(function(i, obj) {
	  if ($(this).attr("data-action")) {
		$(this).click(function() {
		  var data = $(this).data("action");
		  sendData("ButtonClick", data);
		});
	  }
  
	  if ($(this).attr("data-sub")) {
		var menu = $(this).data("sub");
		var element = $("#" + menu);
  
		$(this).click(function() {
		  element.show();
		  $("#mainmenu").hide();
		});
  
		$(".subtop button, .back").click(function() {
		  element.hide();
		  $("#mainmenu").show();
		});
	  }
	});
  }
  
  function sendData(name, data) {
	$.post("http://nav_arsenal/" + name, JSON.stringify(data), function(
	  datab
	) {
	  if (datab != "ok") {
		console.log(datab);
	  }
	});
  }
  
  $('.category_arma').click(function() {
	let pegArma = $(this).attr('category');
	$('.arma-item').css('transform', 'scale(0)');
  
	function hideArma() {
		$('.arma-item').hide();
	}
	setTimeout(hideArma, 100);
  
	function showArma() {
		$('.arma-item[category="' + pegArma + '"]').show();
		$('.arma-item[category="' + pegArma + '"]').css('transform', 'scale(1)');
	}
	setTimeout(showArma, 100);
  });
  
  $('.category_arma[category="all"]').click(function() {
	function showAll() {
		$('.arma-item').show();
		$('.arma-item').css('transform', 'scale(1)');
	}
	setTimeout(showAll, 100);
  });

  