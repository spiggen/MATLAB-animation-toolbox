myapp = canvas();
myapp.UIFigure.WindowState = 'maximized';
drawnow
ax = myapp.ax();
x0 = ax.Position(1);
y0 = ax.Position(2);
dx = ax.Position(3) - x0;
dy = ax.Position(4) - y0;
fig = myapp.UIFigure;
axis(myapp.background, "off")
annotation(fig, 'rectangle',[0 0 1 1],'Color','w');