free = "free"
contact = "contact"
lock = "locking"
pullback = "pullback"
function init()
    state = free
end

--need to lock turret
--why to lock turret
function step()
    if state == "free" then
        roam()
    elseif state == "contact" then
        stop()
    elseif state == "locking" then
        turn_turret()
    elseif state == "pullback" then
        return()
    end
end


function reset()
    state = free
end


function destroy()

end

--roam
-- going to capture
function roam()
    if robot.proximity[1].value > 0.5 then
        robot.wheels.set_velocity(2,2)
        state = contact
    else
        robot.wheels.set_velocity(10,10)
