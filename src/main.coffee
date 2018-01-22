software = []
memorymax = 16
memoryusage = 0
cpumax = 4
cpuusage = 0

log = []

#Initial software
new Software "OS", 8, 1
new Software "Sensors", 1, 1
software[0].enable()

#Various utility functions
sensorTrigger = (id) ->
  switch id
    when 1
      new Software "manipulation", 4, 1
  update()
crash = (reason) ->
  u("#crashreason").html(reason)
  u("#gui").addClass("hidden")
  u("#crash").removeClass("hidden")

  cpuusage = 0
  for i in software
    i.active = false
uncrash = ->
  u("#gui").removeClass("hidden")
  u("#crash").addClass("hidden")

#Update subfunctions
updateGUI = () ->
    u("#software").html("<tr><th colspan=5>software manager</th></tr>
    <tr><td colspan=2>cpu: <span id='cpu'></span></td><td></td><td colspan=2>storage: <span id='memory'></span></td></tr>
    <tr><td>program</td><td>space</td><td>operate</td><td>cpu</td><td>running</td></tr>")
    b = 0
    for i in software
      u("#software").append(sprintf("<tr><td>%s</td><td>%dG</td><td>%s</td><td>%dG</td><td>%t</td></tr>", i.name, i.size, i.operate(b), i.usage, i.active))
      b += 1
    u("#cpu").html(sprintf("%dG/%dG", cpuusage, cpumax))
    u("#memory").html(sprintf("%dG/%dG", memoryusage, memorymax))
    if software[1].active then u("#sensors").removeClass("hidden")
    else u("#sensors").addClass("hidden")


updateRestart = () ->
  unless software[0].active then crash "OS DISABLED"


update = () ->
  updateGUI() #Various graphical updates
  updatRestart() #Restart

window.onload = () ->
  update()
