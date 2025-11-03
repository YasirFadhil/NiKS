{ pkgs, lib, config, ... }:

{
  # Custom GTK CSS for transparency and blur effects
  xdg.configFile."gtk-3.0/gtk.css".text = ''
    /* Custom GTK CSS for Transparency and Blur Effects */

    /* Global window transparency */
    window {
      background-color: rgba(36, 39, 58, 0.85);
      backdrop-filter: blur(20px);
    }

    /* Header bars with transparency */
    headerbar {
      background: rgba(46, 52, 64, 0.80);
      backdrop-filter: blur(15px);
      border-bottom: 1px solid rgba(129, 161, 193, 0.2);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* Sidebar transparency */
    .sidebar {
      background: rgba(46, 52, 64, 0.70);
      backdrop-filter: blur(20px);
    }

    /* Popover menus */
    popover {
      background: rgba(59, 66, 82, 0.85);
      backdrop-filter: blur(25px);
      border: 1px solid rgba(129, 161, 193, 0.3);
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }

    /* Context menus */
    menu {
      background: rgba(59, 66, 82, 0.90);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(129, 161, 193, 0.2);
      border-radius: 12px;
      padding: 4px;
    }

    menuitem {
      border-radius: 8px;
      margin: 1px;
      padding: 8px 12px;
      transition: all 0.2s ease;
    }

    menuitem:hover {
      background: rgba(136, 192, 208, 0.2);
    }

    /* Toolbar transparency */
    toolbar {
      background: rgba(46, 52, 64, 0.75);
      backdrop-filter: blur(15px);
      border-bottom: 1px solid rgba(129, 161, 193, 0.1);
    }

    /* Notebook (tabs) */
    notebook {
      background: transparent;
    }

    notebook > header {
      background: rgba(46, 52, 64, 0.70);
      backdrop-filter: blur(15px);
    }

    notebook > header > tabs > tab {
      background: rgba(59, 66, 82, 0.60);
      border-radius: 8px 8px 0 0;
      margin-right: 2px;
      padding: 8px 16px;
      transition: all 0.2s ease;
    }

    notebook > header > tabs > tab:checked {
      background: rgba(136, 192, 208, 0.3);
    }

    /* Scrolled windows and text views */
    scrolledwindow {
      background: rgba(46, 52, 64, 0.80);
      backdrop-filter: blur(10px);
    }

    textview {
      background: rgba(46, 52, 64, 0.75);
      backdrop-filter: blur(8px);
      border-radius: 8px;
    }

    /* Entry fields */
    entry {
      background: rgba(59, 66, 82, 0.80);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(129, 161, 193, 0.3);
      border-radius: 8px;
      box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
      transition: all 0.2s ease;
    }

    entry:focus {
      background: rgba(59, 66, 82, 0.90);
      border-color: rgba(136, 192, 208, 0.6);
      box-shadow:
        inset 0 1px 3px rgba(0, 0, 0, 0.1),
        0 0 0 2px rgba(136, 192, 208, 0.2);
    }

    /* Buttons */
    button {
      background: rgba(76, 86, 106, 0.80);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(129, 161, 193, 0.3);
      border-radius: 8px;
      padding: 6px 12px;
      transition: all 0.2s ease;
    }

    button:hover {
      background: rgba(94, 129, 172, 0.80);
      box-shadow: 0 2px 8px rgba(94, 129, 172, 0.3);
    }

    button:active {
      background: rgba(129, 161, 193, 0.80);
    }

    /* Suggested action buttons */
    button.suggested-action {
      background: rgba(163, 190, 140, 0.80);
      backdrop-filter: blur(10px);
    }

    button.suggested-action:hover {
      background: rgba(163, 190, 140, 0.90);
      box-shadow: 0 2px 8px rgba(163, 190, 140, 0.4);
    }

    /* Destructive action buttons */
    button.destructive-action {
      background: rgba(191, 97, 106, 0.80);
      backdrop-filter: blur(10px);
    }

    button.destructive-action:hover {
      background: rgba(191, 97, 106, 0.90);
      box-shadow: 0 2px 8px rgba(191, 97, 106, 0.4);
    }

    /* List boxes and rows */
    listbox {
      background: rgba(46, 52, 64, 0.75);
      backdrop-filter: blur(15px);
      border-radius: 12px;
    }

    row {
      background: transparent;
      border-radius: 8px;
      margin: 2px;
      transition: all 0.2s ease;
    }

    row:hover {
      background: rgba(136, 192, 208, 0.15);
    }

    row:selected {
      background: rgba(136, 192, 208, 0.25);
    }

    /* Treeview */
    treeview {
      background: rgba(46, 52, 64, 0.80);
      backdrop-filter: blur(10px);
    }

    treeview:selected {
      background: rgba(136, 192, 208, 0.3);
    }

    /* Progress bars */
    progressbar {
      background: rgba(59, 66, 82, 0.80);
      border-radius: 20px;
      overflow: hidden;
    }

    progressbar > progress {
      background: linear-gradient(90deg,
        rgba(136, 192, 208, 0.8),
        rgba(163, 190, 140, 0.8));
      border-radius: 20px;
    }

    /* Scales (sliders) */
    scale {
      background: transparent;
    }

    scale > trough {
      background: rgba(59, 66, 82, 0.80);
      backdrop-filter: blur(8px);
      border-radius: 20px;
      min-height: 6px;
    }

    scale > highlight {
      background: rgba(136, 192, 208, 0.8);
      border-radius: 20px;
    }

    scale > slider {
      background: rgba(229, 233, 240, 0.90);
      backdrop-filter: blur(5px);
      border: 2px solid rgba(136, 192, 208, 0.6);
      border-radius: 50%;
      min-width: 18px;
      min-height: 18px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    }

    /* Check boxes and radio buttons */
    checkbutton > check,
    radiobutton > radio {
      background: rgba(59, 66, 82, 0.80);
      backdrop-filter: blur(8px);
      border: 2px solid rgba(129, 161, 193, 0.4);
      border-radius: 4px;
    }

    checkbutton > check:checked,
    radiobutton > radio:checked {
      background: rgba(136, 192, 208, 0.8);
      border-color: rgba(136, 192, 208, 0.8);
    }

    radiobutton > radio {
      border-radius: 50%;
    }

    /* Switches */
    switch {
      background: rgba(59, 66, 82, 0.80);
      backdrop-filter: blur(8px);
      border-radius: 20px;
      border: 1px solid rgba(129, 161, 193, 0.3);
    }

    switch:checked {
      background: rgba(163, 190, 140, 0.8);
    }

    switch > slider {
      background: rgba(229, 233, 240, 0.95);
      backdrop-filter: blur(5px);
      border-radius: 50%;
      box-shadow: 0 1px 4px rgba(0, 0, 0, 0.2);
    }

    /* Tooltips */
    tooltip {
      background: rgba(59, 66, 82, 0.95);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(129, 161, 193, 0.3);
      border-radius: 8px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.3);
      color: rgba(229, 233, 240, 0.95);
    }

    /* Dialog boxes */
    dialog {
      background: rgba(46, 52, 64, 0.85);
      backdrop-filter: blur(25px);
      border-radius: 16px;
      box-shadow: 0 16px 64px rgba(0, 0, 0, 0.4);
    }

    /* Message dialog */
    messagedialog {
      background: rgba(46, 52, 64, 0.90);
      backdrop-filter: blur(30px);
    }

    /* File chooser */
    filechooser {
      background: rgba(46, 52, 64, 0.85);
      backdrop-filter: blur(20px);
    }

    /* Scrollbars */
    scrollbar {
      background: transparent;
      border-radius: 10px;
      margin: 2px;
    }

    scrollbar > slider {
      background: rgba(129, 161, 193, 0.4);
      backdrop-filter: blur(5px);
      border-radius: 10px;
      min-width: 8px;
      min-height: 8px;
      transition: all 0.2s ease;
    }

    scrollbar > slider:hover {
      background: rgba(129, 161, 193, 0.6);
    }

    /* Separators */
    separator {
      background: rgba(129, 161, 193, 0.2);
      min-width: 1px;
      min-height: 1px;
    }

    /* Special styling for file managers */
    .nautilus-window {
      background: rgba(46, 52, 64, 0.80);
      backdrop-filter: blur(20px);
    }

    .nautilus-window .sidebar {
      background: rgba(59, 66, 82, 0.70);
      backdrop-filter: blur(15px);
    }

    /* Special styling for terminals */
    .terminal {
      background: rgba(46, 52, 64, 0.80);
      backdrop-filter: blur(15px);
    }

    /* Special styling for text editors */
    .gedit-window {
      background: rgba(46, 52, 64, 0.85);
      backdrop-filter: blur(20px);
    }

    /* Animation keyframes */
    @keyframes fade-in {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    @keyframes slide-down {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* Apply animations to popovers and menus */
    popover,
    menu {
      animation: slide-down 0.2s ease-out;
    }

    /* Smooth transitions for interactive elements */
    button,
    entry,
    checkbutton > check,
    radiobutton > radio,
    switch,
    scale > slider {
      transition: all 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }

    /* Focus ring styling */
    *:focus {
      outline: 2px solid rgba(136, 192, 208, 0.5);
      outline-offset: 2px;
      border-radius: 4px;
    }
  '';

  # GTK4 custom CSS
  xdg.configFile."gtk-4.0/gtk.css".text = ''
    /* GTK4 Custom CSS - Similar styling with GTK4 specific selectors */

    window {
      background-color: rgba(36, 39, 58, 0.85);
    }

    headerbar {
      background: rgba(46, 52, 64, 0.80);
      border-bottom: 1px solid rgba(129, 161, 193, 0.2);
    }

    .sidebar {
      background: rgba(46, 52, 64, 0.70);
    }

    popover {
      background: rgba(59, 66, 82, 0.85);
      border: 1px solid rgba(129, 161, 193, 0.3);
      border-radius: 12px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
    }

    button {
      background: rgba(76, 86, 106, 0.80);
      border: 1px solid rgba(129, 161, 193, 0.3);
      border-radius: 8px;
      transition: all 0.2s ease;
    }

    button:hover {
      background: rgba(94, 129, 172, 0.80);
      box-shadow: 0 2px 8px rgba(94, 129, 172, 0.3);
    }

    entry {
      background: rgba(59, 66, 82, 0.80);
      border: 1px solid rgba(129, 161, 193, 0.3);
      border-radius: 8px;
    }

    entry:focus-within {
      border-color: rgba(136, 192, 208, 0.6);
      box-shadow: 0 0 0 2px rgba(136, 192, 208, 0.2);
    }

    listview {
      background: rgba(46, 52, 64, 0.75);
      border-radius: 12px;
    }

    row {
      background: transparent;
      border-radius: 8px;
      margin: 2px;
    }

    row:hover {
      background: rgba(136, 192, 208, 0.15);
    }

    row:selected {
      background: rgba(136, 192, 208, 0.25);
    }

    scrollbar slider {
      background: rgba(129, 161, 193, 0.4);
      border-radius: 10px;
      min-width: 8px;
      min-height: 8px;
    }

    scrollbar slider:hover {
      background: rgba(129, 161, 193, 0.6);
    }
  '';
}
