class window.TeaserAnimation 

  constructor:    (@teaser_el, options) ->                     
                    @autoplay = options['autoplay']

                    @i = 0 # checkpoint index

                    # create an invisible player
                    $(teaser_el).append($('<div id="teaser-invisible-player">').css('visibility', 'hidden'))
                    @player = new YT.Player('teaser-invisible-player',
                      height: '1',
                      width: '0',
                      videoId: 'HwQMAsOk2dk',
                      events:
                        'onReady': this.player_ready; 
                        'onStateChange': this.player_state_change
                    )                   

  player_ready:         (event) => 
                          if(@autoplay)
                            this.play(event.target)
                          else
                            $('.teaser-animation-control-play').show()

  # events handler
  player_state_change:  (event) => 
                          switch event.data
                            when 0 # end of the music
                              $('.teaser-animation-control-skip').hide()
                              $('.teaser-animation-control-replay').show() # let user replay
                              @animation_end_callback() unless @animation_end_callback is undefined
                            when 1 # beginning of the music
                              $('.teaser-animation-control-skip').show() # let user skip
                              $('.teaser-animation-control-replay').hide() 
                              $('.teaser-animation-control-play').hide() # it is visible if autoplay was false
                              @animation_start_callback() unless @animation_start_callback is undefined


  # register custom callbacks for the beginning and the end of the music
  on_animation_start:   (f) -> @animation_start_callback = f
  on_animation_end:     (f) -> @animation_end_callback = f

  # play music and start sync timer 
  play:           (target = @player) ->
                    target.playVideo()
                    c = this.checkpoints()
                    @animation_timer = window.setInterval( => 
                      t = this.current_time()
                      if(t >= c[@i]['t'] - 1 and t <= c[@i]['t'] + 1) # add some tolerance to sync (+- 0.1s)
                        this.animate(c[@i]['target'], c[@i]['duration'])
                        @i++
                      if(@i == c.length) # no more animations, we can stop the sync timer
                        window.clearInterval(@animation_timer)   
                        @i = 0;                 
                    , 50) 
  
  # pause music, stop sync timer, reset checkpoint index and remove animate class (useful for animations lasting forever), 
  stop:          -> 
                    @player.pauseVideo() 
                    window.clearInterval(@animation_timer)
                    @i = 0
                    $(@teaser_el).children().removeClass('animate')

  # stop and play again
  replay:         ->
                    this.stop()
                    this.play()

  # stop and skip to the end of the music to trigger callbacks
  skip:           ->
                    this.stop()
                    @player.seekTo(@player.getDuration())
                    
  # music current time in s/10
  current_time:   -> parseInt(@player.getCurrentTime() * 10) 



  # attach animation to target
  animate:        (target_selector, duration) => 
                    el = $(target_selector)
                    el.addClass('animate')
                    
                    window.setTimeout( => 
                      el.removeClass('animate')
                    , duration) unless duration is 'forever'  


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

