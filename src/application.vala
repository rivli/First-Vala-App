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
        var layout = new Gtk.Grid ();
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.column_spacing = 6;
        layout.row_spacing = 6;

        var main_button = new Gtk.Button.with_label(_("Click me!"));
        var label = new Gtk.Label(_("Hello, boss!"));
        var counter = 0;    

        main_button.margin = 12;
        main_button.clicked.connect (() => {
            counter++;
            main_button.label = _("Clicked").concat(" ", counter.to_string(), _(" times"));
            main_button.sensitive = true;
        });

        var second_button = new Gtk.Button.with_label(_("Rotate Button"));
        var label2 = new Gtk.Label(null);
        var label3 = new Gtk.Label(_("Horizontal"));

        second_button.clicked.connect (() => {
            label2.label = _("You Just Clicked ").concat(second_button.label);
            label3.angle = 90;
            label3.label = _("Vertical");
            second_button.sensitive = false;
        });

        var notification_label = new Gtk.Label(_("Notifications"));
        var notif_btn_1 = new Gtk.Button.with_label("Frist Notification");

        notif_btn_1.clicked.connect (() => {
            var first_not = new Notification (_("Hello, World!"));
            first_not.set_body (_("This is my first notification!"));
            this.send_notification ("com.github.zakilvir.First-Vala-App", first_not);
        });

        var angry_btn = new Gtk.Button.with_label(_("Angry Button"));
        angry_btn.clicked.connect (() => {
            var second_not = new Notification(_("Warning!"));
            var icon = new GLib.ThemedIcon ("dialog-warning");
            second_not.set_icon (icon);
            second_not.set_body (_("This is my first warning notification!"));
            this.send_notification ("com.github.zakilvir.First-Vala-App", second_not);
        });


        var main_window = new Gtk.ApplicationWindow (this);
        //main_window.default_height = 100;
        //main_window.default_width = 300;
        // also we can do 
        main_window.set_default_size (300, 100);
        main_window.title = _("Hello Word");
        main_window.margin = 6;

        // add first row of widgets
        layout.attach(label, 0, 0, 1, 1);
        layout.attach_next_to(main_button, label, Gtk.PositionType.RIGHT, 1, 1);

        layout.attach(label2, 0, 1, 1, 1);
        layout.attach_next_to(second_button, label2, Gtk.PositionType.RIGHT, 1, 1);

        layout.attach(label3, 3, 0, 2, 2);

        layout.attach(notification_label, 0, 2, 1, 1);
        layout.attach_next_to(notif_btn_1, notification_label, Gtk.PositionType.RIGHT, 1, 1);
        layout.attach_next_to(angry_btn, notif_btn_1, Gtk.PositionType.RIGHT, 1, 1);


        var entry = Unity.LauncherEntry.get_for_desktop_id ("com.github.zakilvir.First-Vala-App.desktop");
        entry.count_visible = true;
        entry.count = 11;

        entry.progress_visible = true;
        entry.progress = 0.87f;

        // Create a root quicklist
        var quicklist = new Dbusmenu.Menuitem ();

        // Create root's children
        var item1 = new Dbusmenu.Menuitem ();
        item1.property_set (Dbusmenu.MENUITEM_PROP_LABEL, "Item 1");
        item1.item_activated.connect (() => {
            message ("Item 1 activated");
        });

        var item2 = new Dbusmenu.Menuitem ();
        item2.property_set (Dbusmenu.MENUITEM_PROP_LABEL, "Item 2");
        item2.item_activated.connect (() => {
            message ("Item 2 activated");
        });

        // Add children to the quicklist
        quicklist.child_append (item1);
        quicklist.child_append (item2);

        // Finally, tell libunity to show the desired quicklist
        entry.quicklist = quicklist;

        main_window.add (layout);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
}
