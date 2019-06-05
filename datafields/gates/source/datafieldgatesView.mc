using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Math as Math;

class datafieldgatesView extends WatchUi.DataField {

    hidden var mValue;

    function initialize() {
        DataField.initialize();
        //mValue = 0.0f;
        mValue = distance(59.458, 27.826, 59.701, 27.514);
    }

    var d2r = (Math.PI / 180.0);
    function deg2rad(deg) {
        return deg * d2r;
    }

    var R = 6371000; // Meters
    function distance(lat1, lon1, lat2, lon2) {
        var x = deg2rad((lon2 - lon1)) * Math.cos(deg2rad( (lat1 + lat2) / 2));
        var y = deg2rad(lat2 - lat1);
        var distance = Math.sqrt(x * x + y * y) * R;
        return distance;
     }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
        var obscurityFlags = DataField.getObscurityFlags();

        // Top left quadrant so we'll use the top left layout
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));

        // Top right quadrant so we'll use the top right layout
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));

        // Bottom left quadrant so we'll use the bottom left layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));

        // Bottom right quadrant so we'll use the bottom right layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));

        // Use the generic, centered layout
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label");
            labelView.locY = labelView.locY - 16;
            var valueView = View.findDrawableById("value");
            valueView.locY = valueView.locY + 7;
        }

        View.findDrawableById("label").setText(Rez.Strings.label);
        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        // See Activity.Info in the documentation for available information.
//        if(info has :currentHeartRate){
//            if(info.currentHeartRate != null){
//                mValue = info.currentHeartRate;
//            } else {
//                mValue = 0.0f;
//            }
//        }
    mValue = distance(59.458, 27.826, 59.701, 27.514);
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

        // Set the foreground color and value
        var value = View.findDrawableById("value");
        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            value.setColor(Graphics.COLOR_WHITE);
        } else {
            value.setColor(Graphics.COLOR_BLACK);
        }
        value.setText(mValue.format("%.3f"));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
