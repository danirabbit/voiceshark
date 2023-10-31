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

        var placeholder = new Granite.Placeholder ("Do your voice training!");

        child = placeholder;
        title = "Voice Shark";
    }
}
