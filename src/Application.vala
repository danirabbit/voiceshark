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

    protected override void activate () {
        if (active_window == null) {
            add_window (new MainWindow ());
        }

        active_window.present ();
    }

    public static int main (string[] args) {
        return new VoiceShark.App ().run (args);
    }
}
