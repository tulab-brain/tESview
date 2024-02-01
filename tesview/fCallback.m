function fCallback(gcf,~)
% This selects new position depending on which subplot a button is clicked.
% Updates display information in mydata.

mydata=get(gcf,'UserData');
pos = get(gca,'CurrentPoint');
pos = round(pos(1,1:2));

switch gca
    case mydata.h(1);mydata.pos([1 3])=pos;
    case mydata.h(2);mydata.pos([2 3])=pos;
    case mydata.h(3);mydata.pos([1 2])=pos;
end

% if new position is valid, update mydata as figure property and display

if ~sum( mydata.pos<1 | mydata.pos>size(mydata.ef_mag))
    set(gcf,'UserData',mydata)
    showimg
end

end