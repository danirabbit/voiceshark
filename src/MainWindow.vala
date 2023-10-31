/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class VoiceShark.MainWindow : Gtk.ApplicationWindow {
    construct {
        titlebar = new Gtk.HeaderBar () {
            show_title_buttons = true
        };
        titlebar.add_css_class (Granite.STYLE_CLASS_FLAT);

        var start_page = new StartPage ();
        var finish_page = new FinishPage ();

        var stack = new Gtk.Stack () {
            transition_type = SLIDE_LEFT_RIGHT
        };
        stack.add_child (start_page);
        stack.add_child (finish_page);

        child = stack;
        default_height = 600;
        default_width = 400;
        title = "Voice Shark";

        stack.notify["visible-child"].connect (() => {
            if (stack.visible_child == finish_page) {
                set_streak ();
            }
        });
    }

    private void set_streak () {
        var settings = new Settings ("io.github.danirabbit.voiceshark");
        var streak = settings.get_int ("streak");
        settings.set_int ("streak", streak + 1);
        settings.set_int64 ("last-completion", new DateTime.now_utc ().to_unix ());
    }
}
