using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor as Monitor;

class MyFirstWatchFaceView extends Ui.WatchFace {

	var centerX;
	var centerY;
	var distanceX;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        distanceX = dc.getWidth() / 13.0;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var activityInfo = Monitor.getInfo();
        var minute = clockTime.min;
        var hour = clockTime.hour;
        if(hour > 12){
        	hour -= 12;
       	}
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
		// Draw the rectangles for the minutes
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
        if((minute >> 5) & 1 == 1){
        	dc.fillRectangle(distanceX, centerY, distanceX, 20);
        } else {
        	dc.drawRectangle(distanceX, centerY, distanceX, 20);
        }
        if((minute >> 4) & 1 == 1){
        	dc.fillRectangle(3 * distanceX, centerY, distanceX, 20);
        } else {
        	dc.drawRectangle(3 * distanceX, centerY, distanceX, 20);
        }
        if((minute >> 3) & 1 == 1){
        	dc.fillRectangle(5 * distanceX, centerY, distanceX, 20);
        } else {
        	dc.drawRectangle(5 * distanceX, centerY, distanceX, 20);
        }
        if((minute >> 2) & 1 == 1){
        	dc.fillRectangle(7 * distanceX, centerY, distanceX, 20);
        } else {
        	dc.drawRectangle(7 * distanceX, centerY, distanceX, 20);
        }
        if((minute >> 1) & 1 == 1){
        	dc.fillRectangle(9 * distanceX, centerY, distanceX, 20);
        } else {
        	dc.drawRectangle(9 * distanceX, centerY, distanceX, 20);
        }
		if(minute & 1 == 1){
        	dc.fillRectangle(11 * distanceX, centerY, distanceX, 20);
        } else {
        	dc.drawRectangle(11 * distanceX, centerY, distanceX, 20);
        }
        
        // Draw the rectangles for the Hour
        if((hour >> 3) & 1 == 1){
        	dc.fillRectangle(5 * distanceX, centerY - 30, distanceX, 20);
        } else {
        	dc.drawRectangle(5 * distanceX, centerY - 30, distanceX, 20);
        }
        if((hour >> 2) & 1 == 1){
        	dc.fillRectangle(7 * distanceX, centerY - 30, distanceX, 20);
        } else {
        	dc.drawRectangle(7 * distanceX, centerY - 30, distanceX, 20);
        }
        if((hour >> 1) & 1 == 1){
        	dc.fillRectangle(9 * distanceX, centerY - 30, distanceX, 20);
        } else {
        	dc.drawRectangle(9 * distanceX, centerY - 30, distanceX, 20);
        }
        if(hour & 1 == 1){
        	dc.fillRectangle(11 * distanceX, centerY - 30, distanceX, 20);
        } else {
        	dc.drawRectangle(11 * distanceX, centerY - 30, distanceX, 20);
        }
        
        // Add the number labels "32", "16",...
        dc.setColor(0xFF5500, Graphics.COLOR_BLACK);
        dc.drawText(distanceX + distanceX / 2, centerY + 20, Graphics.FONT_XTINY, "32", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(3 * distanceX + distanceX / 2, centerY + 20, Graphics.FONT_XTINY, "16", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(5 * distanceX + distanceX / 2, centerY + 20, Graphics.FONT_XTINY, "8", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(7 * distanceX + distanceX / 2, centerY + 20, Graphics.FONT_XTINY, "4", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(9 * distanceX + distanceX / 2, centerY + 20, Graphics.FONT_XTINY, "2", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(11 * distanceX + distanceX / 2, centerY + 20, Graphics.FONT_XTINY, "1", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw the steps
        dc.setColor(0xFF5500, Graphics.COLOR_BLACK);
        dc.drawText(distanceX / 2, centerY + 40, Graphics.FONT_SMALL, activityInfo.steps + "/" + activityInfo.stepGoal, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(centerX + distanceX / 2, centerY + 40, Graphics.FONT_SMALL, activityInfo.activeMinutesWeek + "/" + activityInfo.activeMinutesWeelGoal, Graphics.TEXT_JUSTIFY_LEFT);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
