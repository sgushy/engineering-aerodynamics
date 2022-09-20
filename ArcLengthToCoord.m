function pos = ArcLengthToCoord(AirfoilBP, PanelLengths, arclength)
    curLength = 0;
    index = 1;
%     bpX = [AirfoilBP(1,1:length(AirfoilBP)/2),AirfoilBP(1,length(AirfoilBP)/2+1:length(AirfoilBP))];
%     bpY = [AirfoilBP(2,1:length(AirfoilBP)/2),AirfoilBP(2,length(AirfoilBP)/2+1:length(AirfoilBP))];
%     
    while(curLength < arclength && index<=length(PanelLengths))
       curLength = curLength + PanelLengths(index);
       index = index+1;
    end
    index;
    bpX = AirfoilBP(1,:);
    bpY = AirfoilBP(2,:);
    bpX = bpX(1,index);
    bpY = bpY(1,index);
%     diff = arclength - curLength;
%     slope = atan(bpY/bpX);
%     bpX = bpX + diff*cos(slope);
%     bpY = bpY + diff*sin(slope);
    pos = [bpX,bpY];
end