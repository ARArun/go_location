lock = 0
function init()

end

--need to lock turret
--why to lock turret
function step()
    log("orientation = "..robot.positioning.orientation.angle)
    if robot.proximity[1].value==1 then
        lock=1
        robot.gripper.lock_positive()
    end
    if robot.positioning.position.x >= 0 and lock ==1 then
        robot.set_velocity(0,0)
    elseif lock==1 then
        robot.wheels.set_velocity(-10,-10)
    else
        robot.wheels.set_velocity(10,10)
    end
end


function reset()

end


function destroy()

end
