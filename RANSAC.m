function Bestform =  RANSAC( f1, f2 )
% Adjusting images to right format
I = single(rgb2gray(f1));
J = single(rgb2gray(f2));
% Apply SIFT function to both images, gives descriptors D and locations F 
[F1, D1] = vl_sift(I);
[F2, D2] = vl_sift(J);

% Find matching descriptors from both images
DMatch = vl_ubcmatch(D1,D2);

% Matrix of ones for homogeneous coordinates
homogeneousAppend = ones(1,size(DMatch,2));

MatchF1 = DMatch(1,:);
MatchF2 = DMatch(2,:);

% Find all coordinates for the matching descriptors
for i = 1:size(DMatch,2)
    X1F(i) = F1(1,MatchF1(i));
    Y1F(i) = F1(2,MatchF1(i));
    X2F(i) = F2(1,MatchF2(i));
    Y2F(i) = F2(2,MatchF2(i));
end

% Coordinates of matching points of both images
F1Coordinates = [X1F;Y1F;homogeneousAppend]';
F2Coordinates = [X2F;Y2F;homogeneousAppend]';

% Start the best number of matches at 0
BestMatches = 0;
for j = 1:100
    randSel = randsample(size(DMatch,2),2)
    perm = randperm(size(DMatch,2));
    selection = [perm(randSel(1,1)),perm(randSel(2,1))];

    XF1 = F1Coordinates(selection,1);
    YF1 = F1Coordinates(selection,2);
    while XF1(1,1) == XF1(2,1) & YF1(1,1) == YF1(2,1)
        randSel = randsample(size(DMatch,2),2)
        selection = [perm(randSel(1,1)),perm(randSel(2,1))];
        XF1 = F1Coordinates(selection,1);
        YF1 = F1Coordinates(selection,2);
    end
    CoordinatesF1 = [XF1,YF1];
    
    XF2 = F2Coordinates(selection,1);
    YF2 = F2Coordinates(selection,2);
    if XF2(1,1) == XF2(2,1) & YF2(1,1) == YF2(2,1)
        selection = perm(3:4);
        XF2 = F2Coordinates(selection,1);
        YF2 = F2Coordinates(selection,2);
    end
    CoordinatesF2 = [XF2,YF2];

    form = cp2tform(CoordinatesF1,CoordinatesF2,'nonreflective similarity')
    [calcF2X, calcF2Y] = tformfwd(form, X1F, Y1F);
    calcF2Coordinates = [calcF2X;calcF2Y;homogeneousAppend];

    calcF2Coordinates(:,1) = calcF2Coordinates(:,1) ./ calcF2Coordinates(:,3);
    calcF2Coordinates(:,2) = calcF2Coordinates(:,2) ./ calcF2Coordinates(:,3);
    calcF2Coordinates(:,3) = calcF2Coordinates(:,3) ./ calcF2Coordinates(:,3);
    calcF2Coordinates = calcF2Coordinates';
    Diff = abs(F2Coordinates - calcF2Coordinates);

    Error = 2;
    Matches = 0;

    for i = 1:size(Diff,1)
        if Diff(i,1) < Error & Diff(i,2) < Error
            Matches = Matches + 1;
        end
    end
    
    if Matches > BestMatches
        BestMatches = Matches;
        Bestform = form;
    end
end
    
end

