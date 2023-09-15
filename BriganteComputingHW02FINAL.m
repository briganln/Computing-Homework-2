clear all, close all

I = imread('AxonExample.png');
figure, imshow(I), title ('Original Image (I)');
snapnow
I_gray = im2gray(I);
figure, imshow(I_gray), title('Original Image Grayscale (I_gray)');
snapnow
BW = imbinarize(I_gray);
figure, imshow(BW), title ('Original Binary (BW)');
snapnow

%% 
 T_adapt=adapthisteq(I_gray); %best bleb instenisty differentiation in grayscale
 figure, imshow(T_adapt), title('Adaptive Histogram Equalization (T_adapt)');
 snapnow
 T=.62;
 I_bw=im2bw(T_adapt,T);
 figure, imshow(I_bw), title('Bleb black white');
 snapnow
cc4 = bwconncomp(I_bw,8);
L4 = labelmatrix(cc4);
figure, imagesc(L4), colormap jet, colorbar, title('Bleb Values');
snapnow

Bleb_mask=L4>0;
figure, imshow(Bleb_mask), title('Bleb >0 Mask');

Bleb_mask2=uint8(Bleb_mask); %convert to uint8 to match I_gray data type

Blebs = I_gray.*Bleb_mask2;
figure, imshow(Blebs), title('Bleb Grayscale'), colorbar; 
snapnow

cc4 % Bleb count: 71




%% 

%Convolve
Bleb_blur = imgaussfilt(Blebs,2);
figure, montage({Blebs,Bleb_blur}), title('Gaussian Convolution Comparison');
snapnow
figure, subplot(1,2,1), imagesc(Bleb_blur), axis square, colormap turbo, title('Plot Filter Kernel');
snapnow
figure
subplot(2,2,1), imshow(Blebs), title('Original');
subplot(2,2,2), imshow(Bleb_blur,[]), title('Bleb blur Output');
snapnow


%By applying a gaussian filter kernel using a sigma value of 2, the resulting image is
%blurred allowing for reduced noice in the binary image by eliminating
%irrelevant pixel intenisities from noise.



