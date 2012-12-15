image = im2double(imread('cookies.png'));
binaryCookies = image > isodata('cookies.png');
figure
imshow(binaryCookies)

erodedCookie = imerode(binaryCookies,strel('disk',62,0));
eatenCookieGone = imdilate(erodedCookie,strel('disk',62,0));

figure
imshow(erodedCookie)
figure
imshow(eatenCookieGone)

eatenCookieRecon = imreconstruct(binaryCookies==erodedCookie,binaryCookies);
figure
imshow(eatenCookieRecon)