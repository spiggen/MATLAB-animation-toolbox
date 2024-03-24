function [self, still_post, still_pre] = animation(fcn, from_cell, to_cell, varargin)
% animation returns an animation-object, which is a task scheduled
% to be performed when it's fed into the animate-routine. The animation
% contains a function which is the thing that is actually going to be performed
% for each frame of the animation-sequence. You can then feed
% input-arguments into this function, these input-arguments
% will be fed in for each time they take on a value between from_cell to
% to_cell. The syntax for this is the following:
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



if exist("from_cell", "var") == false
from_cell = {};
to_cell = {};
end


self           = struct;
self.fcn       = fcn;
self.from_cell = from_cell;
self.to_cell   = to_cell;


index = 1;
while index <= numel(varargin)
if isequal(varargin{index}, "KeyRates")
self.KeyRates = varargin{index+1};
elseif isequal(varargin{index}, "KeyFrames")
self.KeyFrames = varargin{index+1};
end
index = index+1;
end

if isfield(self,"KeyRates") == false
self.KeyRates = [0,0];
end

if isfield(self,"KeyFrames") == false
self.KeyFrames = [1,100];
end

if isequal(self.KeyFrames, "all")
self.frame2factor = @(f) 0;
else
self.frame2factor = make_spline(self.KeyFrames, self.KeyRates);
end

still_pre = struct;
still_pre.to_cell = self.to_cell;
still_pre.from_cell = self.from_cell;
still_pre.fcn = self.fcn;
still_pre.KeyFrames = "all";
still_pre.frame2factor = @(f) 0;

still_post = struct;
still_post.to_cell = self.to_cell;
still_post.from_cell = self.from_cell;
still_post.fcn = self.fcn;
still_post.KeyFrames = "all";
still_post.frame2factor = @(f) 1;

end