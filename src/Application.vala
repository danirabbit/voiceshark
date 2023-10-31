/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "io.github.danirabbit.voiceshark",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var headerbar = new Gtk.HeaderBar () {
            show_title_buttons = true
        };
        headerbar.add_css_class (Granite.STYLE_CLASS_FLAT);

        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "Voice Shark",
            titlebar = headerbar
        };
        main_window.present ();
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
