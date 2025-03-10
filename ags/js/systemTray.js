import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export default () => Widget.Box({
    className: 'system-tray',
    connections: [[SystemTray, box => {
        box.children = SystemTray.items.map(item => Widget.Button({
            child: Widget.Icon({
                icon: item.icon,
                size: 20,
            }),
            onPrimaryClick: (_, event) => item.activate(event),
            onSecondaryClick: (_, event) => item.openMenu(event),
            tooltipMarkup: item.tooltipMarkup,
        }));
    }]],
});
