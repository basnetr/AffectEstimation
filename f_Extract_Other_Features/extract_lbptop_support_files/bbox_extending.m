function [new_bbox] = bbox_extending(bbox)

new_bbox(1)=bbox(1)-(bbox(3)/4);
if (new_bbox(1)<1)
    new_bbox(1)=1;
end

new_bbox(2)=bbox(2)-(bbox(4)/4);
if (new_bbox(2)<1)
    new_bbox(2)=1;
end

new_bbox(3)=bbox(3)+(bbox(3)/2);
if (new_bbox(3)>780)
    new_bbox(3)=780;
end

new_bbox(4)=bbox(4)+(bbox(4)/2);
if (new_bbox(4)>580)
    new_bbox(4)=580;
end

end

