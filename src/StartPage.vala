/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class VoiceShark.StartPage : Gtk.Box {
    class construct {
        set_css_name ("page");
    }

    construct {
        var emoji = new Gtk.Label ("👋️");
        emoji.add_css_class ("emoji");

        var title_label = new Gtk.Label (_("Time for Voice Training!")) {
            wrap = true
        };
        title_label.add_css_class (Granite.STYLE_CLASS_ACCENT);

        var streak_label = new Gtk.Label ("");

        var encouragement_label = new Gtk.Label (_("Keep it going tomorrow!"));

        var button = new Gtk.Button.with_label (_("Start"));
        button.add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);

        var box = new Gtk.Box (VERTICAL, 0) {
            valign = CENTER,
            vexpand = true
        };
        box.append (emoji);
        box.append (title_label);
        box.append (streak_label);

        add_css_class ("start");
        orientation = VERTICAL;
        append (box);
        append (button);

        button.clicked.connect (() => {
            ((Gtk.Stack) parent).visible_child = get_next_sibling ();
        });

        var settings = new Settings ("io.github.danirabbit.voiceshark");
        var completed_datetime = new DateTime.from_unix_utc (settings.get_int64 ("last-completion"));

        if (completed_datetime.to_unix () == 0) {
            streak_label.label = _("It's the first day of the rest of your life");
        } else {
            var now_datetime = new DateTime.now_utc ();

            if (Granite.DateTime.is_same_day (completed_datetime, now_datetime)) {
                title_label.label = _("Already done. Good job!");
                button.sensitive = false;
            } else {
                var completed_day = completed_datetime.get_day_of_year ();
                var now_day = now_datetime.get_day_of_year ();
                if (now_day - completed_day > 1) {
                    settings.set_int ("streak", 0);
                }
            }

            var streak = settings.get_int ("streak");

            streak_label.label = ngettext (
                "%i day. last completed %s",
                "%i days. last completed %s",
                streak
            ).printf (
                streak,
                Granite.DateTime.get_relative_datetime (completed_datetime)
            );
        }
    }
}
