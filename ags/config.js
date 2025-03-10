import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from './js/battery.js';
import Clock from './js/clock.js';
import SystemTray from './js/systemTray.js';

// Create a simple bar
const Bar = () => Widget.Window({
    name: 'bar',
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        startWidget: Widget.Box({
            children: [
                Battery(),
            ],
        }),
        centerWidget: Widget.Box({
            children: [
                Clock(),
            ],
        }),
        endWidget: Widget.Box({
            children: [
                SystemTray(),
            ],
        }),
    }),
});

// Export the config
export default {
    style: App.configDir + '/css/style.css',
    windows: [
        Bar(),
    ],
};
