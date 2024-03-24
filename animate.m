function animate(animation_list, KeyFrames)
% The animate-routine takes in a list of animations to be rendered, and
% renders them on top of each-other for each frame, allowing you to write 
% an animation with ony 3 lines or less worth of code.
% 
% my_fun = @(argument1, argument2) plot(argument1, argument2);
% 
% my_anim = animation(@(args)my_fun(args{1},   args{2}), ...        % the function to be performed during animation
%                                   {0:0.1:10, sin(0:0.1:10)}, ...  % field-values corresponding to argument1 and argument2, initial values 
%                                   {0:0.2:20, cos(0:0.2:20)});     % field-values corresponding to argument1 and argument2, end values
% 
% animate({my_anim})                                                % animation routine takes in a list of animations to be performed in parallel
% 
% The animation-routine is then going to interpolate between the initial
% argument-values and the end argument-values to get a smooth animation
% sequence.
% 
% It is also possible to change the keyframes of the animate-routine by
% feeding it a list of keyframes you want to render, for example:
% 
% animate({my_anim}, 0:100);        % Renders the animation for each time the keyframe-number is 0,1,2,3...,100.
% 
% animate({my_anim}, 0:2:100);      % Renders the animation for each time the keyframe-number is 0,2,4,6...,100. 
%                                   % Will go twice as fast as the first one
% animate({my_anim}, 0:0.2:100);    % Renders the animation for each time the keyframe-number is 0,0.2,...,100.  
%                                   % Will go 1/5 as fast as the first one
% animate({my_anim}, [0,50,3,0.2]); % Renders the animation for each time the keyframe-number is 0,50,3,0.2.  
%                                   % The routine uses the keyframes to know where to evaluate the interpolation, 
%                                   % so this animation will appear choppy, but you could if you wanted to for some reason.



if exist("KeyFrames", "var") == false
KeyFrames = 1:100;
end

for frame = KeyFrames

ax = findall(0,'type','axes');
arrayfun(@(ax) plot(ax, 0,0), ax);


for index = 1:numel(animation_list)

if isequal(animation_list{index}.KeyFrames, "all") 

factor = animation_list{index}.frame2factor(frame);

animation_list{index}.fcn(cellwise_inbetween(animation_list{index}.from_cell,   ...
                                             animation_list{index}.to_cell, ...
                                             factor) ...
                          );

arrayfun(@(ax) set(ax, "NextPlot", "add"), ax);


elseif animation_list{index}.KeyFrames(1) <= frame && frame <= animation_list{index}.KeyFrames(2) 
   

factor = animation_list{index}.frame2factor(frame-animation_list{index}.KeyFrames(1));

animation_list{index}.fcn(cellwise_inbetween(animation_list{index}.from_cell,   ...
                                             animation_list{index}.to_cell, ...
                                             factor) ...
                          );

arrayfun(@(ax) set(ax, "NextPlot", "add"), ax);


elseif animation_list{index}.KeyFrames(2) < frame


animation_list{index}.fcn(animation_list{index}.to_cell );


arrayfun(@(ax) set(ax, "NextPlot", "add"), ax);


end

end


drawnow
arrayfun(@(ax) set(ax, "NextPlot", "replacechildren"), ax);
arrayfun(@(ax) set(ax, "ColorOrderIndex", 1), ax);

end
end