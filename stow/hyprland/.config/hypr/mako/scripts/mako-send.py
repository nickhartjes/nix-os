#!/usr/bin/env python3

import sys
import dbus

def notify(summary, body, icon, urgency):
    bus = dbus.SessionBus()
    mako_object = bus.get_object('fr.emersion.Mako', '/fr/emersion/Mako')
    mako_interface = dbus.Interface(mako_object, 'fr.emersion.Mako')

    mako_interface.Notify(summary, body, icon, urgency)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: mako-notify <summary> <body> [icon] [urgency]")
        sys.exit(1)

    summary = sys.argv[1]
    body = sys.argv[2]
    icon = sys.argv[3] if len(sys.argv) > 3 else ''
    urgency = int(sys.argv[4]) if len(sys.argv) > 4 else 1

    notify(summary, body, icon, urgency)
