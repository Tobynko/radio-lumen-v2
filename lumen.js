$(document).ready(function() {


 $('.header__search__bt').on('click',function(){
       var searchinput = $('input.searchbox').val();
       var searchtype = $('select.searchtype').val();
       console.log('searchinput'+searchinput);
       console.log('searchtype'+searchtype);
       if (searchinput.length && searchtype == 'archiv') {
            document.location.href = 'https://www.lumen.sk/archiv.html#'+searchinput+'|all|1';
       }
 });

 $(document).on('click','.showProgCal',function(){
      $('#eventCalendarInline').toggleClass('hidden');
 });


                    $(document).on('click','#vubpaysubmit',function(){
                     
                              $('#vubPayForm').submit();
                            
                        });
                        
												var today = new Date().getTime();
                        if ($("#eventCalendarInline").length) {
                        
												$("#eventCalendarInline").eventCalendar({
													showDayNameInCalendar: false,
													showDescription: false,
                          clickdate: true
												});    
                        }


  $('#search-archive').keypress(function (e) {
    if (e.which == 13) {
      $('#search-submit').trigger('click');
      //return false;    //<---- Add this line
    }
  });
								

 $(document).on('click','.archRelList li a',function(){
          var name = $(this).html();
          console.log('click na'+name);
          $('#search-archive').val(name);
          $('#search-submit').trigger('click');
          
          $('html, body').animate({
            scrollTop: $(".archive__list").offset().top
        }, 2000);
          
      });
      
      
      
      
    $('.removeNewsletter').on('click',function(){
          noty({
              text: 'Ak chete prestať odoberať Newsletter napíšte "ANO" a stlačte "Odhlásiť s newslettra"? <input id="example2" type="text">',
              buttons: [
                {addClass: 'btn btn-primary', text: 'Odhlásiť s newslettra', onClick: function($noty) {
                    // this = button element
                    // $noty = $noty element
            
                    console.log($noty.$bar.find('input#example2').val());
                    var notyval = $noty.$bar.find('input#example2').val();
            
                    $noty.close();
                    
                    if (notyval == 'ANO') {
                         // ajax remove profil
                        var data = '';
                        url = 'pages/ajax/profil/userNewsletterDelete.php';
        

                          var posting = $.post( url, data );
                          // Put the results in a div
                          posting.done(function( data ) {
                             noty({text: 'Boli ste úspešne odhlásený z odoberania newslettra', type: 'success', timeout: '5000'}); 
                             $('.removeNewsletter').hide();
                          });
        
                         
                         
                    } else {
                          noty({text: 'Nesprávny text. Akcia bola prerušená', type: 'error', timeout: '5000'});
                    }
                  }
                },
                {addClass: 'btn btn-danger', text: 'Zrušiť', onClick: function($noty) {
                    $noty.close();
                    noty({text: 'Akcia bola prerušená', type: 'warning', timeout: '5000'});
                  }
                }
              ]
            });
    });  


    $('.removeProfil').on('click',function(){
          noty({
              text: 'Ak chete vymazať svoj profil napíšte "ANO" a stlačte "Vymazať"? <input id="example" type="text">',
              buttons: [
                {addClass: 'btn btn-primary', text: 'Vymazať', onClick: function($noty) {
                    // this = button element
                    // $noty = $noty element
            
                    console.log($noty.$bar.find('input#example').val());
                    var notyval = $noty.$bar.find('input#example').val();
            
                    $noty.close();
                    
                    if (notyval == 'ANO') {
                         // ajax remove profil
                        var data = '';
                        url = 'pages/ajax/profil/userProfilDelete.php';
        

                          var posting = $.post( url, data );
                          // Put the results in a div
                          posting.done(function( data ) {
                             noty({text: 'Váš profil bol úspešne vymazaný', type: 'success', timeout: '5000'});
                             window.location.replace($__root+'odhlasenie.html');
                            
                          });
        
                         
                         
                    } else {
                          noty({text: 'Nesprávny text. Akcia bola prerušená', type: 'error', timeout: '5000'});
                    }
                  }
                },
                {addClass: 'btn btn-danger', text: 'Zrušiť', onClick: function($noty) {
                    $noty.close();
                    noty({text: 'Akcia bola prerušená', type: 'warning', timeout: '5000'});
                  }
                }
              ]
            });
    });
         // Attach a submit handler to the form
    $("#profilForm").submit(function( event ) {
         
    console.log('submit');
        // Stop form from submitting normally
        event.preventDefault();
        // Get some values from elements on the page:
        var $form = $( this );
        var data = $form.serialize();
        url = $form.attr( "action" );
        // Send the data using post

        var posting = $.post( url, data );
        // Put the results in a div
        posting.done(function( data ) {
           noty({text: 'Vaše nastavenia boli úspešne uložené', type: 'success', timeout: '5000'});
        });
       
    });
    $('#my-profile input[type="text"]').autosizeInput();
    
    
   

    if ($('.prtabs').length > 0) {
        $('.prtabs').on('click','a',function(){
            var taburl = $(this).attr('data-href');
            $('.prtabs a').removeClass('active');
            $(this).addClass('active');
            $('.prtab').addClass('hidden');
            $(taburl).removeClass('hidden');
            return false;
        });

        $('.today a').trigger('click');

    }

    $('input[name=submitRegN]').click(function(){

        if ($('input[name=acceptc]').is(':checked')) {
            $('input[name=acceptc]').parent().find('.styled').css('border','1px solid black');
        } else {
            $('input[name=acceptc]').parent().find('.styled').css('border','1px solid red');
            return false;
        }

        if ($('input[name=userPassSec]').val() != $('input[name=userPass]').val()) {
            $('input[name=userPassSec]').css('border','1px solid red');
        } else {
            $('input[name=userPassSec]').css('border','1px solid black');
        }
    });
    
    
    $('input[name=submitChangePass]').click(function(){
        
        var error = 0;
        if ($('input[name=userPass]').val().length < 4) {
            $('input[name=userPass]').css('border','1px solid red');
            error++;
        } else {
            $('input[name=userPass]').css('border','1px solid black');
        }
        
        if ($('input[name=userPassSec]').val() != $('input[name=userPass]').val()) {
            $('input[name=userPassSec]').css('border','1px solid red');
            error++;
        } else {
            $('input[name=userPassSec]').css('border','1px solid black');
        }
        
        if (error > 0) {
            return false;
        }
        
    });
    
    
    
    
    
    

    $('select.searchtype').on('change',function(){
      console.log('ssssssssss');
    });

});

function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}



function facebookLogin() {
    FB.login(function(response) {
   
        if (response.authResponse) {
            createCookie('fb_login','1');
            //console.log(response);
            window.location.replace($__root+'moj-profil.html');
        } else {
            console.log('User cancelled login or did not fully authorize.');
        }
    }, {scope: 'email'});
}


$(document).ready(function(){








    var cookieLogin = readCookie('fb_login');
    if( cookieLogin == '1' ){
        eraseCookie('fb_login');
    }

    /* ----------------------------------------------------- Login & Registration */
    $('a.fbSignIn').bind('click', function(){
        facebookLogin();
        return false;
    });

    $('#topHeadNav .logReg a.signIn').bind('click', function(){
        $('#overlay').fadeIn('fast',function(){
            $('#winSignIn').show();
        });
        return false;
    });

    $('#topHeadNav .logReg a.registration').bind('click', function(){
        $('#overlay').fadeIn('fast',function(){
            $('#winSignUp').show();
        });
        return false;
    });

    $('#overlay, .winSignReg .close').bind('click', function(){
        $('.winSignReg').hide();
        $('#overlay').fadeOut('fast');
    });

    var emailT = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;// /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

    if ( $('#winSignUp').length > 0 ) {
        var type;
        var val;
        var validString;

        $('#winSignUp input.validation').focus(function(){
            if ( $(this).val() == 'Povinná hodnota'
                || $(this).val() == 'Zlý formát emailu'
                || $(this).attr('placeholder') == 'Chyba min. 5 znakov'
                || $(this).attr('placeholder') == 'Heslá sa nezhodujú.') {
                $(this).attr('style','').val('');
            }
        });

        $('#winSignUp input.passSec').bind('click', function(){
            if( $(this).attr('placeholder') == 'Heslá sa nezhodujú.' ){
                $(this).attr('style','').val('');
            }
        });

        $('#winSignUp input[type="submit"]').bind('click', function(){


            validString = '';
            var secPass = $('#winSignUp input.passSec').val();

            $('#winSignUp input.validation').each(function(){
                type = $(this).attr('data-validate');
                val = $(this).val();

                switch(type){
                    case 'string':
                        if ( val.length < 1 ) {
                            $(this).css({'border-color' : '#ff0000', color: '#ff0000'})
                                .val('Povinná hodnota');
                            validString += '-false';
                        }
                        break;
                    case 'email':
                        if( !emailT.test( val) || val.length === 0) {
                            validString += '-false';
                            $(this).css({'border-color' : '#ff0000', color: '#ff0000'})
                                .val('Zlý formát emailu');
                        }
                        break;
                    case 'pass':
                        if ( val.length < 5 ) {
                            $(this).css({'border-color' : '#ff0000', color: '#ff0000'})
                                .val('')
                                .attr('placeholder','Chyba min. 5 znakov');
                            validString += '-false';
                        } else {
                            if ( secPass !== $(this).val() ){
                                validString += '-false';
                                $(this).css({'border-color' : '#ff0000', color: '#ff0000'})
                                    .attr('placeholder','Heslá sa nezhodujú.').val('');
                                $('#winSignUp input.passSec').css({'border-color' : '#ff0000', color: '#ff0000'})
                                    .attr('placeholder','Heslá sa nezhodujú.').val('');
                            }
                        }
                        break;
                    default :
                        validString += '-true';
                }

            });

            if ( validString.indexOf('false') > 0 ) {
                return false;
            } else {
                return true;
            }
        });
    }


    if ( $('#winSignIn').length > 0 ) {
        var typeLog;
        var valLog;
        var validStringLog;

        $('#winSignIn input.validation').focus(function(){
            if ( $(this).val() == 'Zlý formát emailu'
                || $(this).attr('placeholder') == 'Chyba min. 5 znakov' ) {
                $(this).attr('style','').val('');
            }
        });

        $('#winSignIn input[type="submit"]').bind('click', function(){

            validStringLog = '';

            $('#winSignIn input.validation').each(function(){
                typeLog = $(this).attr('data-validate');
                valLog = $(this).val();

                console.log('tu');

                switch(typeLog){
                    case 'email':
                        if( !emailT.test( valLog ) || valLog.length === 0) {
                            validStringLog += '-false';
                            $(this).css({'border-color' : '#ff0000', color: '#ff0000'})
                                .val('Zlý formát emailu');
                        }
                        break;
                    case 'pass':
                        if ( valLog.length < 5 ) {
                            $(this).css({'border-color' : '#ff0000', color: '#ff0000'})
                                .val('')
                                .attr('placeholder','Chyba min. 5 znakov');
                            validString += '-false';
                        }
                        break;
                    default :
                        validStringLog += '-true';
                }

            });

            if ( validStringLog.indexOf('false') > 0 ) {
                return false;
            } else {
                return true;
            }
        });
    }
    /* ----------------------------------------------------- Login & Registration end */

    /* ----------------------------------------------------- fix placeholders IE */
    $('.lt-ie10 [placeholder]').focus(function() {
        var input = $(this);
        if (input.val() == input.attr('placeholder')) {
            input.val('');
            input.removeClass('placeholder');
        }
    }).blur(function() {
        var input = $(this);
        if (input.val() == '' || input.val() == input.attr('placeholder')) {
            input.addClass('placeholder');
            input.val(input.attr('placeholder'));
        }
    }).blur();
    /* ----------------------------------------------------- fix placeholders IE end*/





    /* ----------------------------------------------------- footer box size fix */
    $(document).ready(function(){
        var maxHeight = 0;
        $('#footer .middle .box')
            .each(function() { maxHeight = Math.max(maxHeight, $(this).height()); })
            .css({'height' : maxHeight+'px'});
    });
    /* ----------------------------------------------------- footer box size fix end*/





    /* ----------------------------------------------------- fancy box */
    if($('#newsBox .article div.gallery').length > 0 ){
        $("#newsBox .article div.gallery a[rel=article_gallery]").fancybox({
            'transitionIn'		: 'none',
            'transitionOut'		: 'none',
            'titlePosition' 	: 'over'
        });
    }
    /* ----------------------------------------------------- fancy box end */

    $('.fancyboxDoc').fancybox({
        'transitionIn'		: 'none',
        'transitionOut'		: 'none',
        'titlePosition' 	: 'over'
    });



    /* ----------------------------------------------------- web font size */
    $('#topHeadNav .sizeFont li a.bigger').bind('click', function(){
        var actualFontSize = parseInt($('body').css('font-size'));

        var fontToSet = actualFontSize < 15 ? actualFontSize++ : actualFontSize;
        $('body').css({'font-size' : actualFontSize+'px'});

        return false;
    });

    $('#topHeadNav .sizeFont li a.lower').bind('click', function(){
        var actualFontSize = parseInt($('body').css('font-size'));

        var fontToSet = actualFontSize > 13 ? actualFontSize-- : actualFontSize;
        $('body').css({'font-size' : actualFontSize+'px'});

        return false;
    });
    /* ----------------------------------------------------- web font size end*/



    /* ----------------------------------------------------- effects */
    $('#searchBox input[type=text]').focus(function(){
        $(this).animate({color : '#323332'}, 300);
    });
    $('#searchBox input[type=text]').blur(function(){
        $(this).animate({color : '#cecece'}, 300);
    });

    $('#carouselAfter li').hover(function(){
        $(this).stop().animate({backgroundColor : '#eef2e1'},300);
    },function(){
        $(this).stop().animate({backgroundColor : '#fff'},300);
    });
    /* ----------------------------------------------------- effects end */



    /* ----------------------------------------------------- daily program */
    if($('#dailyProgram .programTabs').length > 0){
        $('#dailyProgram .programTabs').tabs();
    }
    
    $('.clonetabs ul li a').on('click',function(){
        $('.clonetabs ul li a').removeClass('active');
        $(this).addClass('active');
        var datahref = $(this).data('href');
        $('.programTabs a[data-href='+datahref+']').trigger('click');
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });
    
    $('.programtabs ul li a').on('click',function(){
        var datahref = $(this).data('href');
         $('.clonetabs ul li a').removeClass('active');
        $('.clonetabs a[data-href='+datahref+']').addClass('active');
       
    });
    
    $('.clonetabs a.calleft').on('click',function(){
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });
    $('.clonetabs a.calright').on('click',function(){
        $("html, body").animate({ scrollTop: 0 }, "slow");
    });
    /* ----------------------------------------------------- daily program end */



    /* ----------------------------------------------------- about us */
    if($('#aboutUs').length > 0){
        $('#aboutUs .icon').bind('click', function(){
            if($(this).parent().children('.aboutUsContent').is(':visible')){
                $(this).removeClass('open');
            } else {
                $(this).addClass('open');
            }
            $(this).parent().children('.aboutUsContent').slideToggle('slow');
        });
    }
    /* ----------------------------------------------------- about us end */


    /* ----------------------------------------------------- my profile */
    if($('#my-profile').length > 0){
        $('#my-profile .inputLine img.edit').bind('click', function(){
            $(this).parent().children('input').attr('disabled', false).focus();
        });
    }

    if($('.rolling').length > 0){
        $('.rolling .icon').bind('click', function(){
            if($(this).parent().parent().children('.rollContent').is(':visible')){
                $(this).removeClass('open');
            } else {
                $(this).addClass('open');
            }
            $(this).parent().parent().children('.rollContent').slideToggle('slow');
        });
    }

    $('#hp-properties .categoriesList ul li label').bind('click', function(){
        if ($(this).parent().find('input').is(':checked')) {
            $(this).removeClass('active');
        } else {
            $(this).addClass('active');
        }
    });

    $('#favouritesRelacie .favouritesList td.deleteCont label').bind('click', function(){
        $(this).parent().parent().fadeOut('slow');
    });
    /* ----------------------------------------------------- my profile end */



    // Attach a submit handler to the form
    $( "#newsletterForm" ).submit(function( event ) {
        // Stop form from submitting normally
        event.preventDefault();
        // Get some values from elements on the page:
        var $form = $( this );
        var data = $form.serialize();
        url = $form.attr( "action" );
        var posting = $.post( url, data );
        // Put the results in a div
        posting.done(function( data ) {
            var data = $.parseJSON(data);

            if (data.data == 1){
                noty({text: 'Neuviedli ste emailovú adresu.', type: 'error', timeout: '5000'});
            }
            if (data.data == 2){
                noty({text: 'Uvedená emailová adresa má nesprávny tvar.', type: 'error', timeout: '5000'});
            }
            if (data.data == 3){
                noty({text: 'Zadaný email sa už v našej databáze nachádza.', type: 'warning', timeout: '5000'});
            }
            if (data.data == 4){
                noty({text: 'Pre aktiváciu prosím kliknite na odkaz, vo vašom maily.', type: 'success', timeout: '5000'});
            }


        });

    });

    $(document).on('click','input#landmark',function(){
        $('input[name=submitRegN]').removeAttr('disabled');
    });

    $("#landmark").focus(function(event){
        event.preventDefault();
        $('input[name=submitRegN]').prop("disabled", false);
    });


    // webkamera
    $('.button__livecam').on('click',function() {

        var currentdate = new Date();
        if (currentdate.getHours() >= 22 || currentdate.getHours() <= 6){
            noty({text: 'Webkamera Rádia Lumen je dostupná každý deň v čase od 6:00 do 22:00 hodiny', type: 'warning', timeout: '5000'});
        }  else {
            var link = $(this).attr('data-link');
            window.open(link, 'popup1', 'width=320, height=240, top=175, left=500, menubar=0, scrollbars=0, location=0, toolbar=0,  resizable=0, status=0');
        }
    });

    $('.button__live').on('click',function() {
        if ($('#playerActualff').is(':visible')){
            window.open($__root+'radio-streaming.html?ff=1', 'stream', 'width=800,height=520');
        } else {
            window.open($__root+'radio-streaming.html', 'stream', 'width=800,height=520');
        }
    });
     // mobile
    $('.button__live2').on('click',function() {
        window.open($__root+'radio-streaming.html', 'stream', 'width=800,height=520');
    });



    // radio prave hrame
    function refreshPlaylistActual(){
        $('#playerActual').load($__root+'pages/ajax/playlistActual.php', function(){
            setTimeout(refreshPlaylistActual, 10000);
        });
    }
    refreshPlaylistActual();

    function refreshPlaylistActualff(){
        $('#playerActualff').load($__root+'pages/ajax/playlistActualff.php', function(){
            setTimeout(refreshPlaylistActualff, 90000);
        });
    }
    refreshPlaylistActualff();

    $('.live-app__select .selectpicker').change(function(){
         var val = $(this).val();
         $('.radiotitle').hide();
         $('#'+val).show();
         
         var data = {setradio:val};
         url = $__root+'newpages/ajax/setRadioSession.php';
         var posting = $.post( url, data );        
    });
    
    $('.live-app__select button').click(function(){
         $('.live-app__select button').removeClass('active');
         $(this).addClass('active');
         var val = $(this).val();
         $('.radiotitle').hide();
         $('#'+val).show();
         
         var data = {setradio:val};
         url = $__root+'newpages/ajax/setRadioSession.php';
         var posting = $.post( url, data );   
         return false;     
    });
    
    

    $(document).on('click','a[data-action=play]',function(){
        window.open($__root+'archiv-play/'+$(this).data('id'), 'stream', 'width=713,height=260');
        return false;
    });
    
 
 
 var flashWidthTitle = $('#flash-news .title').width()+80;
    
        if (readCookie('flashnews') == 'closed') {
                $('.flash-close').addClass('closed');
                $('#flash-news .scrollWrapper').css("left","-100%");
                $('.flash-close').css("left",flashWidthTitle+"px");
                $('.lumen-icon-close::before').css('content','\25BA');
        }
    
        $('.flash-close').on('click', function(){
            if ($(this).hasClass('closed')){
                $(this).removeClass('closed');
                $('.lumen-icon-close::before').css('content','\00d7');
                $('#flash-news .scrollWrapper').animate({left: "0"});
                $(this).css('left','auto');
                eraseCookie('flashnews');

            } else {
                $(this).addClass('closed');
                $('#flash-news .scrollWrapper').animate({left: "-100%"});
                $(this).animate({left: flashWidthTitle+"px"});
                $('.lumen-icon-close::before').css('content','\25BA');
                createCookie('flashnews','closed','1');
            }
        });
    
        $('div.holder #flash-news ul.scrollableArea').marquee({
          //speed in milliseconds of the marquee
          duration: 50000,  
          //gap in pixels between the tickers
          gap: 50,
          //time in milliseconds before the marquee will start animating
          delayBeforeStart: 0,
          //'left' or 'right'
          direction: 'left',
          //true or false - should the marquee be duplicated to show an effect of continues flow
          duplicated: true,
          pauseOnHover: true
      });
      
      $('.program-app__pr.customScroller').mCustomScrollbar({setTop: "100px"}); 
      
      

});

$(window).load(function(){
      $('#currentnext').prev().attr('id','current');
      $('.program-app__pr.customScroller').mCustomScrollbar("scrollTo",'#current');
});
