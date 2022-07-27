local allowCountdown = false;
function onStartCountdown()
    if not allowCountdown and isStoryMode then
        allowCountdown = true;
        startDialogue('dialogue');

        cameraSetTarget('boyfriend');
        return Function_Stop;
    end
    return Function_Continue;
end