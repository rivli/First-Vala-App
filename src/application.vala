/*
* Copyright (c) 2011-2018 Zakiryanov Ilvir
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Ilvir <zakilvir@gmail.com>
*/

public class MyApp : Gtk.Application {
    public MyApp() {
        Object (
            application_id: "com.github.zakilvir.First-Vala-App",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        var main_button = new Gtk.Button.with_label(_("Click me!"));
        var label = new Gtk.Label(_("Hello, boss!"));
        main_button.margin = 12;
        var counter = 0;
        main_button.clicked.connect (() => {
            counter++;
            main_button.label = _("Clicked").concat(" ", counter.to_string(), _(" times"));
            main_button.sensitive = true;
        });
        var main_window = new Gtk.ApplicationWindow (this);
        //main_window.default_height = 100;
        //main_window.default_width = 300;
        // also we can do 
        main_window.set_default_size (300, 100);
        main_window.title = _("Hello Word");
        grid.add(label);
        grid.add(main_button);
        main_window.add (grid);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
}
