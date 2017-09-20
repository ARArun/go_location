free = "free"
contact = "contact"
lock = "locking"
pullback = "pullback"
count_time = 0
function init()
    state = free
    robot.turret.set_position_control_mode()
end

--need to lock turret
--why to lock turret
function step()
    if state == "free" then
        roam()
    elseif state == "contact" then
        ang = stop()
    elseif state == "locking" then
        turn_turret(ang)
    elseif state == "pullback" then
        pull()
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
    robot.wheels.set_velocity(10,10)
    for i = 1,24 do
        if robot.proximity[i].value == 1 then
            ang = robot.proximity[i].angle
            state = contact
        end
    end
    return ang
end

--contact
--here we stop when any part of robot
--contacts the obstacle
function stop()
    sensor_no=0
    sensor_angle=0
    for i = 1,24 do
        if robot.proximity[i].value == 1 then
            robot.wheels.set_velocity(0,0)
            state = lock
            sensor_no = i
            sensor_angle = robot.proximity[i].angle
        end
    end
    return sensor_angle
end

--turn_turret
--we turn the turret to the angle we need
-- we pullback
-- what if another robot comes near and then this state has arrived
function turn_turret(ang)
    count_time = count_time + 1
    robot.wheels.set_velocity(0,0)
    robot.turret.set_rotation(ang)
    robot.gripper.lock_positive()
    if count_time == 50 then
        state = pullback
        count_time = 0
    end
end


--function pull
--going back to original position
function pull ()
    if math.abs(robot.positioning.position.x) <= 0.05 then
        robot.wheels.set_velocity(0,0)
    else
        robot.wheels.set_velocity(-10,-10)
    end
end
