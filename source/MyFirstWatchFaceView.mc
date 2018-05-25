using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor as Monitor;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Gregorian;

class MyFirstWatchFaceView extends Ui.WatchFace {

	var watchWidth;
	var centerX;
	var centerY;
	var distanceX;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        watchWidth = dc.getWidth();
        centerX = watchWidth / 2;
        centerY = dc.getHeight() / 2;
        distanceX = watchWidth / 13.0;
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
        /*var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);*/

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
		// Draw the rectangles for the minutes
        dc.setColor(0xFFFFFF, Graphics.COLOR_BLUE);
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
        
        // Draw activity bars
        dc.setColor(0x55AA55, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, centerY + 43, ((watchWidth * 1.0) / activityInfo.stepGoal) * (activityInfo.steps * 1.0), 19);
        dc.setColor(0xFF5500, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, centerY + 63, ((watchWidth * 1.0) / activityInfo.activeMinutesWeekGoal) * (activityInfo.activeMinutesWeek.total * 1.0), 19);
        Sys.println(((watchWidth * 1.0) / activityInfo.activeMinutesWeekGoal) * (activityInfo.activeMinutesWeek.total * 1.0));
        dc.setColor(0x00AAAA, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, centerY + 83, watchWidth / activityInfo.floorsClimbedGoal * activityInfo.floorsClimbed, 19);
        
        // Draw the activity info
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(3, centerY + 40, Graphics.FONT_SMALL, activityInfo.steps + "/" + activityInfo.stepGoal, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(watchWidth - 3, centerY + 40, Graphics.FONT_SMALL, " steps", Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(3, centerY + 60, Graphics.FONT_SMALL, activityInfo.activeMinutesWeek.total + "/" + activityInfo.activeMinutesWeekGoal, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(watchWidth - 3, centerY + 60, Graphics.FONT_SMALL, " minutes", Graphics.TEXT_JUSTIFY_RIGHT);
        dc.drawText(3, centerY + 80, Graphics.FONT_SMALL, activityInfo.floorsClimbed + "/" + activityInfo.floorsClimbedGoal, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(watchWidth - 3, centerY + 80, Graphics.FONT_SMALL, " floors", Graphics.TEXT_JUSTIFY_RIGHT);
        
        // Draw the status bar
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$ $3$", [today.day_of_week, today.day, today.month]);
        dc.drawText(3, 0, Graphics.FONT_XTINY, dateString, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawRectangle(watchWidth - 25, 5, 20, 11);
        dc.drawRectangle(watchWidth - 5, 8, 2, 5);
        var systemSettings = Sys.getDeviceSettings();
        var statusString = "";
        if(systemSettings.phoneConnected){
        	statusString += "B";
        }
        if(systemSettings.alarmCount > 0){
        	statusString += Lang.format("A$1$", [systemSettings.alarmCount]);
        }
        if(systemSettings.notificationCount > 0){
        	statusString += Lang.format("N$1$", [systemSettings.notificationCount]);
        }
        dc.drawText(watchWidth - 28, 0, Graphics.FONT_XTINY, statusString, Graphics.TEXT_JUSTIFY_RIGHT);
        var systemStats = Sys.getSystemStats();
        dc.fillRectangle(watchWidth - 25, 5, (20 / 100.0) * systemStats.battery, 11);       
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
