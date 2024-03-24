function frame2factor = make_spline(interval, rate)
n = interval(2) - interval(1);
mat = [0         0        0       1;
       n^3      n^2       n       1;
       0        0         1       0;
       3*n^2    2*n       1       0];

c = mat\[0;1;rate(1);rate(2)];


frame2factor = @(frame) c(1)*(frame.^3) + c(2)*(frame.^2) + c(3)*frame + c(4);
end