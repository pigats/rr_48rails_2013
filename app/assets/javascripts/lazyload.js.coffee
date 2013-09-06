class window.LazyLoad

  constructor:  (@src) -> this.load()
  
  load:         -> $('head script').last().after($('<script>').attr('src', @src))
