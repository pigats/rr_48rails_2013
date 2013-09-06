class window.TeaserAnimation 

  constructor:    (@teaser_el) -> 
                    @i = 0 # checkpoint index

                    # create an invisible player
                    $(teaser_el).append($('<div id="teaser-invisible-player">').css('visibility', 'hidden'))
                    @player = new YT.Player('teaser-invisible-player',
                      height: '1',
                      width: '0',
                      videoId: 'HwQMAsOk2dk',
                      events:
                        'onReady': (event) => this.play(event.target); 
                        'onStateChange': this.player_state_change
                    )                   

  # play music and start sync timer 
  play:           (target = @player) ->  
                    target.playVideo() 
                    c = this.checkpoints()
                    @animation_timer = window.setInterval( => 
                      t = parseInt(@player.   getCurrentTime() * 10) # music current time in s/10
                      if(t > c[@i]['t'] - 2 and t < c[@i]['t'] + 2) # add some tolerance to sync (+- 0.2s)
                        this.animate(c[@i]['target'], c[@i]['duration'])
                        @i++
                      if(@i == c.length) # no more animations, we can stop the sync timer
                        window.clearInterval(@animation_timer)   
                        @i = 0;                 
                    , 50) 
  
  # pause music and stop sync timer
  pause:          -> 
                    @player.pauseVideo() 
                    window.clearInterval(@animation_timer)
                    $(@teaser_el).children().removeClass('animate')


  replay:         ->
                    this.pause()
                    @i = 0
                    $('.animate').removeClass('.animate')
                    this.play()

  skip:           ->
                    this.pause()
                    @player.seekTo(@player.getDuration())
                    


  current_time:   -> @player.getCurrentTime()
  
  on_animation_start:   (f) -> @animation_start_callback = f
  on_animation_end:     (f) -> @animation_end_callback = f

  player_state_change:  (event) => 
                          switch event.data
                            when 0 
                              $('.teaser-animation-control-skip').hide()
                              $('.teaser-animation-control-replay').show()
                              @animation_end_callback() unless @animation_end_callback is undefined
                            when 1
                              $('.teaser-animation-control-skip').show()
                              $('.teaser-animation-control-replay').hide()                              
                              if this.current_time() in [0, @player.getDuration()]
                                 @animation_start_callback() unless @animation_start_callback is undefined

  # checkpoints
  checkpoints:    ->

                    [
                      {t:  28, target: '.teaser-image[data-order=1]',  duration: 3100},   
                      {t:  66, target: '.teaser-text[data-order=1]',   duration: 4100},
                      {t: 104, target: '.teaser-image[data-order=2]',  duration: 3100},                       
                      {t: 143, target: '.teaser-text[data-order=2]',   duration: 4100},
                      {t: 178, target: '.teaser-image[data-order=3]',  duration: 3100}, 
                      {t: 218, target: '.teaser-text[data-order=3]',   duration: 4100},                      
                      {t: 256, target: '.teaser-image[data-order=4]',  duration: 3100},
                      {t: 314, target: '.teaser-text[data-order=4]',   duration: 4100},
                      {t: 332, target: '.teaser-text[data-order=5]',   duration: 4100},
                      {t: 351, target: '.teaser-text[data-order=6]',   duration: 4100},
                      # {t: 371
                      {t: 389, target: '.teaser-text[data-order=7]',   duration: 4100},
                      {t: 408, target: '.teaser-text[data-order=8]',   duration: 4100},
                      # {t: 427
                      {t: 466, target: '.teaser-image[data-order=5]',  duration: 'forever'},
                      # {t: 484, },
                      # {t: 503, },
                      {t: 540, target: '.teaser-text[data-order=9]',   duration: 4100},
                      {t: 558, target: '.teaser-text[data-order=10]',   duration: 4100},
                      {t: 578, target: '.teaser-text[data-order=11]',   duration: 4100},
                      {t: 615, target: '.teaser-text[data-order=12]',   duration: 4100}                  
                    ]


  # attach animation to target
  animate:        (target_selector, duration) => 
                    el = $(target_selector)
                    el.addClass('animate')
                    
                    window.setTimeout( => 
                      el.removeClass('animate')
                    , duration) unless duration is 'forever'  
