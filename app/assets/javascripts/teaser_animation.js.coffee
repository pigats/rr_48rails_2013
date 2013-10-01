class window.TeaserAnimation 

  constructor:    (@teaser_el, options) ->                     
                    @autoplay = options['autoplay']

                    @i = 0 # checkpoint index

                    # create an invisible player
                    $(teaser_el).append($('<div id="teaser-invisible-player">').css('visibility', 'hidden'))
                    @player = new YT.Player('teaser-invisible-player',
                      height: '1',
                      width: '0',
                      videoId: 'F8JHmjKI0Io', #HwQMAsOk2dk',
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
                      {t: 27, target: '.teaser-image[data-order=1]',  duration: 3100},   
                      {t: 60, target: '.teaser-text[data-order=1]',   duration: 4100},
                      {t: 93, target: '.teaser-image[data-order=2]',  duration: 3100},                       
                      {t: 126, target: '.teaser-text[data-order=2]',   duration: 4100},
                      {t: 157, target: '.teaser-image[data-order=3]',  duration: 3100}, 
                      {t: 194, target: '.teaser-text[data-order=3]',   duration: 4100},                      
                      {t: 227, target: '.teaser-image[data-order=4]',  duration: 3100},
                      {t: 276, target: '.teaser-text[data-order=4]',   duration: 4100},
                      {t: 291, target: '.teaser-text[data-order=5]',   duration: 4100},
                      {t: 308, target: '.teaser-text[data-order=6]',   duration: 4100},
                      {t: 342, target: '.teaser-text[data-order=7]',   duration: 4100},
                      {t: 359, target: '.teaser-text[data-order=8]',   duration: 4100},
                      {t: 411, target: '.teaser-image[data-order=5]',  duration: 'forever'},
                      {t: 477, target: '.teaser-text[data-order=9]',   duration: 4100},
                      {t: 493, target: '.teaser-text[data-order=10]',   duration: 4100},
                      {t: 510, target: '.teaser-text[data-order=11]',   duration: 4100},
                      {t: 545, target: '.teaser-text[data-order=12]',   duration: 4100}                  
                    ]


