function [samples, frameRate] = getAudio(fromMili, toMili, audioData, frameRate)
    readFrom = round(fromMili*frameRate/1000);
    readTo = round(toMili*frameRate/1000);
    samples = audioData(readFrom:readTo);
end