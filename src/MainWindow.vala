/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class VoiceShark.MainWindow : Gtk.ApplicationWindow {
    private Granite.Placeholder placeholder;
    private Gtk.Button button;
    private Settings settings;

    construct {
        titlebar = new Gtk.HeaderBar () {
            show_title_buttons = true
        };
        titlebar.add_css_class (Granite.STYLE_CLASS_FLAT);

        placeholder = new Granite.Placeholder (_("Do your voice training!"));

        button = placeholder.append_button (
            new ThemedIcon ("process-completed"),
            _("Done"),
            _("I've completed my voice training")
        );

        child = placeholder;
        title = "Voice Shark";

        settings = new Settings ("io.github.danirabbit.voiceshark");
        settings.changed.connect (get_streak);
        get_streak ();

        button.clicked.connect (set_streak);
    }

    private void get_streak () {
        var completed_datetime = new DateTime.from_unix_utc (settings.get_int64 ("last-completion"));

        if (completed_datetime.to_unix () == 0) {
            placeholder.description = _("It's the first day of the rest of your life 🎉️");
            return;
        }

        var now_datetime = new DateTime.now_utc ();

        if (Granite.DateTime.is_same_day (completed_datetime, now_datetime)) {
            placeholder.title = _("Already done. Good job!");
            button.sensitive = false;
        } else {
            var completed_day = completed_datetime.get_day_of_year ();
            var now_day = now_datetime.get_day_of_year ();
            if (now_day - completed_day > 1) {
                settings.set_int ("streak", 0);
            }
        }

        var streak = settings.get_int ("streak");

        placeholder.description = ngettext (
            "last completed %s. %i day",
            "last completed %s. %i days",
            streak
        ).printf (
            Granite.DateTime.get_relative_datetime (completed_datetime),
            streak
        );
    }

    private void set_streak () {
        var streak = settings.get_int ("streak");
        settings.set_int ("streak", streak + 1);
        settings.set_int64 ("last-completion", new DateTime.now_utc ().to_unix ());
    }
}
