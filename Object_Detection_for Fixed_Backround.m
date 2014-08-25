    Video_Path = 'D:\temp\A2.wmv';
    
    Sampling_Rate = 25;
   
    Video_Temp = VideoReader(Video_Path);
    lastFrame = read(Video_Temp, inf);
    Total_Frames = Video_Temp.NumberOfFrames;
    
    RGB_Frame_Mth = read(Video_Temp, 25);
    Gray_Frame_Mth = rgb2gray(RGB_Frame_Mth);
    Filt_Frame_Mth = medfilt2(Gray_Frame_Mth, [4 4]);
    BW_Frame_Mth = im2bw(Filt_Frame_Mth, 0.01);
    Frame_Mth = bwareaopen(BW_Frame_Mth,280); 
    Label_Frame_Mth = bwlabel(Frame_Mth, 8 );

    for N = 200 : Sampling_Rate : Total_Frames
    
    RGB_Frame_Nth = read(Video_Temp, N);
    Subtract_Frame_Nth = rgb2gray(RGB_Frame_Nth);
    Filt_Frame_Nth = medfilt2(Subtract_Frame_Nth, [4 4]);
    BW_Frame_Nth = im2bw(Filt_Frame_Nth, 0.18);
    Frame_Nth = bwareaopen(BW_Frame_Nth,280); 
    Label_Frame_Nth = bwlabel(Frame_Nth, 8 );
    Final_Frame_1 = imsubtract(Label_Frame_Nth, Label_Frame_Mth);
    Filt_Frame_Nth_1 = medfilt2(Final_Frame_1, [4 4]);
    BW_Frame_Nth_1 = im2bw(Filt_Frame_Nth_1, 0.1);
    Frame_Nth_1 = bwareaopen(BW_Frame_Nth_1,400); 
    Label_Frame_Nth_1 = bwlabel(Frame_Nth_1, 8 );
    stats = regionprops(Label_Frame_Nth_1, 'BoundingBox', 'Centroid');
    
    imshow(RGB_Frame_Nth);
    
    hold on
    
    if(length(stats)>0)
    Bound_Boxs = stats(1).BoundingBox;
    Object_Center = stats(1).Centroid;
    rectangle('Position',Bound_Boxs,'EdgeColor','r','LineWidth',2)
    Present_Coordinates = round(Object_Center);
    plot(Object_Center(1),Object_Center(2), '-m+')
    a=text(Object_Center(1)+25,Object_Center(2), strcat('X: ', num2str(Present_Coordinates(1)), '    Y: ', num2str(Present_Coordinates(2))));
    set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    end
    
    hold off

    end

   