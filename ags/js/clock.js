import Widget from 'resource:///com/github/Aylur/ags/widget.js';

export default () => Widget.Label({
    className: 'clock',
    setup: self => self.poll(1000, label => {
        const date = new Date();
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        label.label = ` ${hours}:${minutes}`;
    }),
});
