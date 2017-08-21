lock = 0
function init()

end

--need to lock turret
--why to lock turret
function step()
    if robot.proximity[1].value==1 then
        lock=1
        robot.gripper.lock_positive()
    end
    if lock==1 then
        robot.wheels.set_velocity(-5,-5)
    else
        robot.wheels.set_velocity(10,10)
    end
end


function reset()

end


function destroy()

end
