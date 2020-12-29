function [newBox] = extendBox(bbox)
    if (size(bbox,1) > 1 )  %Assumes only one with size greater the [200x200] is a face
        for k = 1:size(bbox,1)
           tempBbox = bbox(k,:);
           if (tempBbox(3) > 200 && tempBbox(4) > 200)
                bbox = tempBbox;
                break;
           end
        end
    end   
    if size(bbox,1) > 1
        bbox = []; %empty
    end
    if ~(isempty(bbox)) && (bbox(3) < 200 && bbox(4) < 200)
        bbox = [];
    end
    if ~(isempty(bbox))
        newBox(1) = round(bbox(1) - (bbox(3)/16)); %/4
        newBox(2) = round(bbox(2) - (bbox(4)/16)); %/4
        newBox(3) = round(bbox(3) + (bbox(3)/8)); %/2
        newBox(4) = round(bbox(4) + (bbox(4)/8)); %/2

        if (newBox(1) < 1) 
            newBox(1) = 1;
        end

        if (newBox(2) < 1) 
            newBox(2) = 1;
        end

        if (newBox(3) > 780) 
            newBox(3) = 780;
        end

        if (newBox(4) > 580) 
            newBox(4) = 580;
        end
    else
        newBox = []; %empty
    end
end

