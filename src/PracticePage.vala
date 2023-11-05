/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Danielle Foré (https://danirabbit.github.io)
 */

public class VoiceShark.PracticePage : Gtk.Box {
    class construct {
        set_css_name ("page");
    }

    construct {
        var header_label = new Granite.HeaderLabel ("");

        var image = new Gtk.Image () {
            valign = CENTER,
            vexpand = true
        };
        image.add_css_class (Granite.STYLE_CLASS_LARGE_ICONS);

        var button = new Gtk.Button.with_label (_("Continue"));
        button.add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);

        orientation = VERTICAL;
        append (header_label);
        append (image);
        append (button);

        button.clicked.connect (() => {
            ((Gtk.Stack) parent).visible_child = get_next_sibling ();
        });

        switch (Random.int_range (0, 3)) {
            case 0:
                header_label.label = _("Deep Breathing");
                header_label.secondary_text = _("Inhale slowly as the ring shrinks and exhale slowly as it expands");
                image.icon_name = "breathe-symbolic";
                image.add_css_class ("breathe");
                break;
            case 1:
                header_label.label = _("Pitch Glide");
                header_label.secondary_text = _("Start with a comfortable pitch, glide up to the highest pitch in your range, then back to your starting pitch");
                image.icon_name = "glide-both-symbolic";
                break;
            case 2:
                header_label.label = _("Pitch Glide");
                header_label.secondary_text = _("Start with the highest pitch you can and glide down to a comfortable pitch");
                image.icon_name = "glide-down-symbolic";
                break;
            case 3:
                header_label.label = _("Pitch Glide");
                header_label.secondary_text = _("Start with a comfortable pitch, then glide up to the highest pitch in your range");
                image.icon_name = "glide-up-symbolic";
        }
    }
}
