import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';

export default () => Widget.Label({
    className: 'battery',
    connections: [[Battery, label => {
        const percent = Battery.percent || 0;
        const charging = Battery.charging;
        const icon = charging ? ' ' : percent <= 20 ? ' ' : ' ';
        label.label = `${icon}${percent}%`;
    }]],
});
