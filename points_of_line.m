% Function for finding the points that lie at a certain distance, epsilon,
% from the lines.
function pts = points_of_line(points, line, epsilon)

% Make the coordinates of points homogeneous
for i = 1:size(points,1)
points(i,3) = 1;    
end

counter = 0;
% Check if the dot product between the points and a line, thus the
% perpendicular distance, is less or equal to epsilon. If so, add that
% point to the return parameter pts.
for i = 1:size(points,1)
    for j = 1:size(line,2)
        if dot(points(i,:),line(:,j)) <= epsilon
            counter = counter + 1;
            pts(counter,:) = points(i,:);
        end
    end
end


end