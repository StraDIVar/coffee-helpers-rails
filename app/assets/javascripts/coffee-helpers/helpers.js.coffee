$.extend
  EMPTY_HREF: 'javascript:void(0);'
  NBSP: ' ' # &nbsp; symbol

  parseParamsFromUrl: (url) ->
    paramString = url.split('?')[1] || ''
    if paramString.length > 2
      JSON.parse '{"' + paramString.replace(/&/g, '","').replace(/=/g,'":"') + '"}', (key, value) ->
        if key == '' then value else decodeURIComponent(value)
    else
      {}

  component: (id) ->
    document.getElementById(id)?.component

  sleep: (milliseconds) ->
    start = (new Date).getTime()

    i = 0
    period = 0
    while i < 1e7
      period = (new Date).getTime() - start
      if period >= milliseconds
        break
      i++

    return period

  numberWithCommas: (stringOrNumber) ->
    return '' unless typeof stringOrNumber in ['string', 'number']

    stringOrNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')

$.fn.extend
  modify: (mainClass, modifier, add) ->
    if arguments.length != 3
      throw new Error('ERROR :: $.fn.modify :: 3 arguments expected')
    else
      classWithModifier = "#{mainClass}--#{modifier}"
      if add
        @
        .filter(".#{mainClass}, [class^='#{mainClass}--']")
        .not(".#{classWithModifier}")
        .addClass(classWithModifier)
      else # remove
        @
        .filter(".#{classWithModifier}")
        .removeClass(classWithModifier)
        .addClass(mainClass) # for fix cases when element hasn't main class without modifier

      return @

  unmodify: (mainClass) ->
    if arguments.length != 1
      throw new Error('ERROR :: $.fn.unmodify :: 1 argument expected')
    else
      mainClassLength = mainClass.length
      @.removeClass (index, classes) ->
        classesWithModifiers = _.filter classes.split(' '), (value) ->
          value.slice(0, mainClassLength + 2) == "#{mainClass}--"
        classesWithModifiers.join(' ')

      return @

  classHasModifier: (mainClass, modifier = '') ->
    argumentsLength = arguments.length
    if argumentsLength != 1 && argumentsLength != 2
      throw new Error('ERROR :: $.fn.classHasModifier :: 1 or 2 arguments expected')
    else
      @.hasClass("#{mainClass}--#{modifier}")

  toggleModifier: (mainClass, modifier = '') ->
    argumentsLength = arguments.length
    if argumentsLength != 1 && argumentsLength != 2
      throw new Error('ERROR :: $.fn.toggleModifier :: 1 or 2 arguments expected')
    else
      @.modify(mainClass, modifier, !@.classHasModifier(mainClass, modifier))

  forceCss: ->
    # It is a hack to reflow and apply css rules before animation
    @.offset()?.left

  cssHide: (hiddenClass = 'rewardexpert__hidden') ->
    @.addClass(hiddenClass)

  cssShow: (hiddenClass = 'rewardexpert__hidden') ->
    @.removeClass(hiddenClass)

  cssToggle: ->
    if arguments[1]?
      action = arguments[0]
      hiddenClass = arguments[1]

    else if arguments[0]?
      action = arguments[0] if _.isBoolean arguments[0]
      hiddenClass = arguments[0] if _.isString arguments[0]

    else
      action = @.hasClass(hiddenClass)
      hiddenClass = 'rewardexpert__hidden' # default

    @[if action then 'cssShow' else 'cssHide'](hiddenClass)
