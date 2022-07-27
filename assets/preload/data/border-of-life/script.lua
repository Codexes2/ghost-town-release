local allowCountdown = false;
function onStartCountdown()
    if not allowCountdown and isStoryMode then
        allowCountdown = true;
        if (difficulty == 2) then
            startDialogue('dialogue-hard');
        else
            startDialogue('dialogue');
        end
        cameraSetTarget('boyfriend');
        return Function_Stop;
    end
    return Function_Continue;
end