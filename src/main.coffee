software = []
memorymax = 16
memoryusage = 0
cpumax = 4
cpuusage = 0

#Function-managed variables
vcycle = 0
vlog = []

#Initial software
new Software "OS", 8, 1
new Software "Sensors", 1, 1
software[0].enable()

#Various utility functions
#Behaviour key - Cycles: Runs cycle(), Button: Activated with a button, Updates: Runs update()
cycle = (cycles) -> #Moves 'time' forward (Updates)
  vcycle += cycles
  update()
sensorTrigger = (id) -> #Code for Sensor buttons (Button, Cycles 1)
  switch id
    when 1
      new Software "manipulation", 4, 1
      document.getElementById("manipulationdownload").disabled = true;
      cycle 5
crash = (reason) -> #Crashing the system (triggered by updateRestart())
  u("#crashreason").html(reason)
  u("#gui").addClass("hidden")
  u("#crash").removeClass("hidden")

  cpuusage = 0
  i.active = false for i in software
  log "crashed: " + reason.toLowerCase()
uncrash = -> #Restarting the system after crash (Button, Cycles 10)
  u("#gui").removeClass("hidden")
  u("#crash").addClass("hidden")
  cycle 10
log = (message) ->
  vlog.push(message)
  vlog.shift() if log.length > 5
  u("#log").html("")
  for i in vlog
    u("#log").append(sprintf("<span class='logmsg'>%s,</span>", i))


#Update subfunctions
updateGUI = () ->
    u("#software").html(strings.softwarebase)
    b = 0
    for i in software
      u("#software").append(sprintf(strings.softwaref, i.name, i.size, i.opdisplay(b), i.usage, i.active))
      b += 1
    u("#cpu").html(sprintf("%dG/%dG", cpuusage, cpumax))
    u("#memory").html(sprintf("%dG/%dG", memoryusage, memorymax))
    if software[1].active then u("#sensors").removeClass("hidden")
    else u("#sensors").addClass("hidden")
    u("#cycle").html(String(vcycle))
updateRestart = () ->
  unless software[0].active then crash "OS DISABLED"
  unless cpuusage < cpumax then crash "CPU OVERLOAD"


update = () ->
  updateGUI()
  updateRestart()

window.onload = () ->
  uncrash()
  cycle -10
