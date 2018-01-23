class Software
  constructor: (name, size, usage) ->
    this.name = name
    this.size = size
    this.usage = usage
    this.active = false
    memoryusage += size

    software.push this
  enable: ->
    unless this.active
      if cpuusage + this.usage > cpumax
        return false
      else
        cpuusage += this.usage
        this.active = true
    else return false
  disable: ->
    if this.active
      cpuusage -= this.usage
      this.active = false
    else return false
  operate: ->
    if this.active then this.disable() else this.enable()
    cycle 1
  opdisplay: (id) -> sprintf("<button onclick='software[%d].operate()'>Toggle</button>", id)
