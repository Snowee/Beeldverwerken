function BestMatches =  RANSAC( f1, f2 )
I = single(rgb2gray(f1));
J = single(rgb2gray(f2));

[F1, D1] = vl_sift(I);
[F2, D2] = vl_sift(J);


DMatch = vl_ubcmatch(D1,D2);

homogeneousAppend = ones(1,size(DMatch,2))

MatchF1 = DMatch(1,:);
MatchF2 = DMatch(2,:);

for i = 1:size(DMatch,2)
    X1F(i) = F1(1,MatchF1(i))
    Y1F(i) = F1(2,MatchF1(i))
    X2F(i) = F2(1,MatchF2(i))
    Y2F(i) = F2(2,MatchF2(i))
end

F1Coordinates = [X1F;Y1F;homogeneousAppend]'

F2Coordinates = [X2F;Y2F;homogeneousAppend]'
for j = 1:100
    perm = randi(size(DMatch,2), 1, size(DMatch,2));
    selection = perm(1:2);

    XF1 = F1(1, selection);
    YF1 = F1(2, selection);

    CoordinatesF1 = [XF1;YF1]';

    XF2 = F2(1, selection);
    YF2 = F2(2, selection);

    CoordinatesF2 = [XF2;YF2]';

    form = cp2tform(CoordinatesF1,CoordinatesF2,'nonreflective similarity');
    F2BEREKENDEPUNTEN = tformfwd(form, xcoordF1, ycoordF1)

    calcF2Coordinates = TransMatrix * F1Coordinates';
    calcF2Coordinates = calcF2Coordinates'
    calcF2Coordinates(:,1) = calcF2Coordinates(:,1) ./ calcF2Coordinates(:,3);
    calcF2Coordinates(:,2) = calcF2Coordinates(:,2) ./ calcF2Coordinates(:,3);
    calcF2Coordinates(:,3) = calcF2Coordinates(:,3) ./ calcF2Coordinates(:,3);

    Diff = abs(F2Coordinates - calcF2Coordinates)

    Error = 2;
    Matches = 0;

    for i = 1:size(Diff,1)
        if Diff(i,1) < Error & Diff(i,2) < Error
            Matches = Matches + 1;
        end
    end
    BestMatches = 0
    if Matches > BestMatches
        BestMatches = Matches;
    end
end
    
end

