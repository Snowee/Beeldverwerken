function t=isodata(image)
image = im2double(imread(image));

fmin = min(min(image));
fmax = max(max(image));

t = .5*(fmin+fmax);

while(true)
    m1 = mean(image(image<=t));
    m2 = mean(image(image>t));
    t = .5*(m1+m2);
    
    if round((t-m1)*1000) == round((m2-t)*1000)
        break;
    end
end

end