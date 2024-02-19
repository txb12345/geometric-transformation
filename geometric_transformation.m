function output_image = geometric_transformation(image)
[height, width] = size(image);
% Calculate the center coordinates 
center_x = width / 2;
center_y = height / 2;
k = 0.05; % distortion parameter
angle = 30; % flight angle parameter
output_image = uint8(zeros(size(image)));
theta = deg2rad(angle); % Convert flight angle parameter to the corresponding radians

for y = 1:height
    for x = 1:width        
        dx = x - center_x;
        dy = y - center_y;
        % Calculate the distance from the current pixel to the center coordinates
        distance = sqrt(dx^2 + dy^2);
        % Calculate the pixel radians from the current pixel to the center coordinates 
        pixel_angle = atan2(dy, dx);
        
        % Calculate the distortion radius
        r = distance * (1 + k * distance);
        
        % Calculate the distorted coordinates
        distorted_x = round(center_x + r * cos(pixel_angle - theta));
        distorted_y = round(center_y + r * sin(pixel_angle - theta));
        
        % Handle the boundaries of the distorted coordinates
        distorted_x = min(max(distorted_x, 1), width);
        distorted_y = min(max(distorted_y, 1), height);
        output_image(x, y) = image(distorted_x, distorted_y);
    end
end

end