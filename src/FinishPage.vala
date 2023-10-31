/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class VoiceShark.FinishPage : Gtk.Box {
    class construct {
        set_css_name ("page");
    }

    construct {
        var settings = new Settings ("io.github.danirabbit.voiceshark");
        var streak = settings.get_int ("streak");

        var emoji = new Gtk.Label ("🎉️");
        emoji.add_css_class ("emoji");

        var streak_label = new Gtk.Label (
            ngettext (
                "%i Day",
                "%i Days",
                streak + 1
            ).printf (
                streak + 1
            )
        );
        streak_label.add_css_class (Granite.STYLE_CLASS_ACCENT);

        var encouragement_label = new Gtk.Label (_("Keep it going tomorrow!"));

        add_css_class ("finish");
        orientation = VERTICAL;
        valign = CENTER;
        append (emoji);
        append (streak_label);
        append (encouragement_label);
    }
}
