function pts = points_of_line(points, line, epsilon)


for i = 1:size(points,1)
points(i,3) = 1;    
end
counter = 0;

for i = 1:size(points,1)
    for j = 1:size(line,2)
        if dot(points(i,:),line(:,j)) <= epsilon
            counter = counter + 1;
            pts(counter,:) = points(i,:);
        end
    end
end


end