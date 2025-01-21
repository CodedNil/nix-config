user_pref("browser.aboutConfig.showWarning", false);
user_pref("privacy.donottrackheader.enabled", true);

// Edit weather widget
user_pref("browser.newtabpage.activity-stream.weather.display", "detailed");
user_pref("browser.newtabpage.activity-stream.weather.temperatureUnits", "c");

// Disable lazy restore
user_pref("browser.sessionstore.restore_on_demand", false);
user_pref("browser.sessionstore.restore_pinned_tabs_on_demand", false);
user_pref("browser.sessionstore.restore_tabs_lazily", false);

// Disable saving logins
user_pref("signon.rememberSignons", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("signon.autofillForms", false);

// Tweaks to scrolling
user_pref("general.autoScroll", true);
user_pref("toolkit.tabbox.switchByScrolling", true);

// UI customisation state
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"ublock0_raymondhill_net-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"dearrow_ajay_app-browser-action\",\"openmultipleurls_ustat_de-browser-action\",\"vpn_proton_ch-browser-action\",\"_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action\"],\"nav-bar\":[\"personal-bookmarks\",\"urlbar-container\",\"back-button\",\"forward-button\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\"],\"vertical-tabs\":[],\"PersonalToolbar\":[],\"zen-sidebar-top-buttons\":[\"customizableui-special-spring15\",\"zen-workspaces-button\",\"customizableui-special-spring14\"],\"zen-sidebar-icons-wrapper\":[\"preferences-button\",\"78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action\",\"sync-button\",\"addon_darkreader_org-browser-action\",\"downloads-button\"]},\"seen\":[\"openmultipleurls_ustat_de-browser-action\",\"78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action\",\"addon_darkreader_org-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"vpn_proton_ch-browser-action\",\"_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"dearrow_ajay_app-browser-action\",\"developer-button\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"vertical-tabs\",\"zen-sidebar-icons-wrapper\",\"zen-sidebar-top-buttons\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":20,\"newElementCount\":16}");

// Disable most suggestions in url bar
user_pref("browser.urlbar.suggest.clipboard", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);

// Disable most sync types
user_pref("services.sync.declinedEngines", "passwords,addresses,creditcards,forms,history");
user_pref("services.sync.engine.addresses.available", false);
user_pref("services.sync.engine.extension-storage", true);
user_pref("services.sync.engine.forms", false);
user_pref("services.sync.engine.history", false);
user_pref("services.sync.engine.passwords", false);
user_pref("services.sync.engine.prefs.modified", false);
user_pref("services.sync.engine.workspaces", true);

// Zen settings
user_pref("zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url", true);
user_pref("zen.sidebar.enabled", false);
user_pref("zen.splitView.change-on-hover", true);
user_pref("zen.tab-unloader.enabled", false);
user_pref("zen.theme.accent-color", "#aac7ff");
user_pref("zen.theme.color-prefs.colorful", true);
user_pref("zen.urlbar.behavior", "normal");
user_pref("zen.view.use-single-toolbar", false);
user_pref("zen.view.compact", true);
user_pref("zen.view.compact.hide-tabbar", false);
user_pref("zen.view.compact.hide-toolbar", true);
user_pref("zen.view.show-newtab-button-border-top", false);
user_pref("zen.welcome-screen.seen", true);

// Zen mods settings
user_pref("uc.essentials.box-like-corners", true);
user_pref("uc.essentials.color-scheme", "transparent");
user_pref("uc.essentials.gap", "Normal");
user_pref("uc.essentials.width", "Normal");
user_pref("uc.pins.bg", false);
user_pref("uc.pins.essentials-layout", false);
user_pref("uc.pins.hide-reset-button", true);
user_pref("uc.pins.legacy-layout", true);
user_pref("uc.tabs.custom_color_hex", "#ffffff");
user_pref("uc.tabs.dim_unloaded", false);
user_pref("uc.tabs.preferred_color", "");
user_pref("uc.urlbar.blur-intensity", "");
user_pref("uc.urlbar.border", false);
user_pref("uc.urlbar.icon.left-side.removed", false);
user_pref("uc.urlbar.icon.reader-mode.removed", false);
user_pref("uc.urlbar.icon.shield.removed", true);
user_pref("uc.urlbar.icon.show-on-hover", false);
user_pref("uc.urltext.center", "normal");
user_pref("w.urlbar.bg_color", "#0066ff66, #00ffff66, #0066ff66");