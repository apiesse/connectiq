using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class batteryWidgetView extends Ui.View {
    hidden enum {
        STR_BATTERY_LABEL = 0,
        STR_BATTERY_CHARGING,
        STR_MAX
    }
    hidden var strings = new[STR_MAX];

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        strings[STR_BATTERY_LABEL]    = WatchUi.loadResource(Rez.Strings.BatteryLabel);
        strings[STR_BATTERY_CHARGING] = WatchUi.loadResource(Rez.Strings.BatteryCharging);
        //setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var batteryLabel;
        var batteryPercentage;

        // set background color
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, width, height);
        // set foreground color
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);

        //
        batteryLabel = strings[STR_BATTERY_LABEL];
//      if(Sys.getSystemStats().charging)
//          {
//          batteryLabel = Lang.format("$1$ ($2$)", [batteryLabel, strings[STR_BATTERY_CHARGING]]);
//          }
        batteryPercentage = Lang.format("$1$%", [Sys.getSystemStats().battery.format("%d")]);

        dc.drawText((width/2),
                    (height/2)-(Gfx.getFontHeight(Gfx.FONT_NUMBER_THAI_HOT)/2),
                    Gfx.FONT_SYSTEM_SMALL,
                    batteryLabel,
                    Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText((width/2),
                    (height/2),
                    Gfx.FONT_NUMBER_THAI_HOT,
                    batteryPercentage,
                    Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);

        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
