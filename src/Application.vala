/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class VoiceShark.App : Gtk.Application {
    public App () {
        Object (
            application_id: "io.github.danirabbit.voiceshark",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    construct {
        add_main_option ("background", 'b', NONE, NONE, "Run the Application in background", null);
    }

    protected override void startup () {
        Granite.init ();

        Intl.setlocale (ALL, "");
        Intl.bindtextdomain (application_id, "/app/share/locale");
        Intl.bind_textdomain_codeset (application_id, "UTF-8");
        Intl.textdomain (application_id);

        var quit_action = new SimpleAction ("quit", null);
        quit_action.activate.connect (quit);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"<Control>q"});

        base.startup ();
    }

    protected override int handle_local_options (VariantDict options) {
        if (options.contains("background")) {
            request_background.begin ();
        }

        return -1;
    }

    protected override void activate () {
        if (active_window == null) {
            add_window (new MainWindow ());
        }

        active_window.present ();
    }

    public async void request_background () {
        var portal = new Xdp.Portal ();

        Xdp.Parent? parent = active_window != null ? Xdp.parent_new_gtk (active_window) : null;

        var command = new GenericArray<weak string> ();
        command.add (application_id);
        command.add ("--background");

        try {
            if (yield portal.request_background (
                parent,
                _("Voice Shark will automatically start when this device turns on and run when its window is closed so that it can send notifications to remind you about voice training."),
                (owned) command,
                Xdp.BackgroundFlags.AUTOSTART,
                null
            )) {
                var notification = new Notification (_("It's time to do your voice training!"));
                notification.set_body (_("Don't lose that streak"));

                send_notification ("pratice-reminder", notification);

                hold ();
            } else {
                release ();
            }
        } catch (Error e) {
            if (e is IOError.CANCELLED) {
                debug ("Request for autostart and background permissions denied: %s", e.message);
                release ();
            } else {
                warning ("Failed to request autostart and background permissions: %s", e.message);
            }
        }
    }

    public static int main (string[] args) {
        return new VoiceShark.App ().run (args);
    }
}
