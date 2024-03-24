function [self, V] = save_animation(ax,filename)
% save_animation is a utility to create an animation-object which, when put
% into the animation-routine, saves the animation to a file.
% Example:
% 
% my_axes = axes();
% 
% my_fun = @(argument1, argument2) plot(my_axes, argument1, argument2);
% 
% [saver, videoObj] = save_animation(my_axes, "sine2cosine_video.mp4")
% 
% my_anim = animation(@(args)my_fun(args{1},   args{2}), ...        % the function to be performed during animation
%                                   {0:0.1:10, sin(0:0.1:10)}, ...  % field-values corresponding to argument1 and argument2, initial values 
%                                   {0:0.2:20, cos(0:0.2:20)});     % field-values corresponding to argument1 and argument2, end values
% 
% animate({my_anim, saver})                                         % animation routine takes in a list of animations to be performed in parallel
% 
% close(videoObj)


V = VideoWriter(filename, "MPEG-4");
open(V);
%V.FileFormat = "mp4";

self = animation(@(c) writeVideo(V, frame2im(getframe(ax))), {0}, {1}, "KeyFrames", "all");



end