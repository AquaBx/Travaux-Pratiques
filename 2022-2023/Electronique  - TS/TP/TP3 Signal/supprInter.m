function [SegmentationVector] = supprInter(SegmentationVector,size_s,framerate)
    derReff = diff(SegmentationVector);
    x1 = find(derReff == 1);
    y1 = find(derReff == -1);
    if ~isempty(x1) && ~isempty(y1)
        if y1(1) < x1(1)
             x1 =[1;x1];
        end
        if y1(end) < x1(end)
            y1 =[y1;length(SegmentationVector)];
        end
    end
    tr = y1-x1;
    petit_inter = find(tr<size_s*framerate);
    for y=1:length(petit_inter)
        SegmentationVector(x1(petit_inter(y)):y1(petit_inter(y))) = 0;
    end
end