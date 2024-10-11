%% Lab 2 Q3

%% A
img = imread("KillarneyPic.png"); 
info = imfinfo("KillarneyPic.png");
%file size is 429220 bytes
%bits per pixel is 8.

%% B
img2 = im2double(img); %converts to double
%imshow(img2); %displays image
size_img = size(img2);

%% C impulse sampling

impulse_sample = zeros(size_img);

size_x = size_img(1);
size_y = size_img(2);
fs = 5;

for n = 1:fs:size_x
    
    for j = 1:fs:size_y
        
        impulse_sample(n,j) = img2(n,j);
        
    end
    
end

imshow(impulse_sample);

%% C downsampling 

size_dsx = size_x / fs;
size_dsy = size_y / fs;
size_dsx = round(size_dsx);
size_dsy = round(size_dsy);

down_sample = zeros(size_dsx,size_dsy);

for n = 1:size_dsx
    
    for j = 1:size_dsy-1
        
        down_sample(n,j) = img2(n*fs,j*fs);
        
    end
    
end

imshow(down_sample);

%% C zerohold

zero_hold = zeros(size(img2));

for n = 1:size_dsx %iterate through x
    
    for j = 1:size_dsy-1 %iterate through y
        
        for k = 1:5 %5x5 matrix      
            
            for m = 1:5
                
                zero_hold((n-1)*fs+k,(j-1)*fs+m) = down_sample(n,j); %does 1-25
                
            end
        
        end
        
    end
end


imshow(zero_hold);

%% C 

%interpolate all across the x axis first
%then interpolate all across y axis

%take two points, split into five use linspace to create a vector which
%evenly makes two points through x1 and x2.

first_hold1 = zeros(size(img2));

temp1 = down_sample(1,1);
temp2 = down_sample(1,2);
temp3 = linspace(temp1, temp2, 6);
l = 1;

for n = 1:size_dsx
    
    for j = 1:size_dsy-1
        
        first_hold1(n*5,j) = down_sample(n,j);
        
    end
    
end


for n = 1:size_y %iterates through 776 already done in previous
    
    for j = 1:size_dsx-1 %iterates through 156
                
        temp1 = first_hold1(j,n);
        temp2 = first_hold1(j*5,n);
        temp3 = linspace(temp1, temp2, 6);
        
        for k=2:5
            
            first_hold1((j-1)*5+l,n) = temp3(k);
            l = l+1;
        end
        l = 1;
        
    end
    
end


for n = 1:size_x
    
    for j = 1:size_dsy-1
        
        first_hold1(n,j*5) = first_hold1(n,j);
        
    end
    
end


for n = 1:size_x %iterate thrrough x 
    
    for j = 1:size_dsy-1 %iterate through y
                
        temp1 = first_hold1(n,j);
        temp2 = first_hold1(n,j*5);
        temp3 = linspace(temp1, temp2, 6);
        
        for k=2:5
            
            first_hold1(n,(j-1)*5+l) = temp3(k);
            l = l+1;
        end
        l = 1;
        
    end
end



%{
temp1 = 0; %holds current value
temp2 = 0; %holds next value
temp3 = [0,0,0,0,0,0]; %holds values inbetween

 temp1 = down_sample(1,1);
 temp2 = down_sample(1,2);
 temp3 = linspace(temp1, temp2, 6);

for n = 1:size_dsx
    
    for j = 1:size_dsy
        
        first_hold1((n)*fs,(j)*fs) = down_sample(n,j);
        
    end
    
end

first_hold2 = first_hold1;
temp1 = first_hold2(n,j);
temp2 = first_hold2(n,j*5);
temp3 = linspace(temp1, temp2, 6);
l = 0;

for n = 1:size_x
    
    for j = 1:size_y
        
        temp1 = first_hold2((n-1)*fs,j);
        temp2 = first_hold2((n-1)*fs,j);
        temp3 = linspace(temp1, temp2, 6);
        
        for k = 2:5
            
            first_hold2(n,j+l) = temp3(k);
            l = l+1;
        end
        
        l = 0;
        
    end
    
end

%}
%imshow(first_hold1);
imshow(first_hold1);






