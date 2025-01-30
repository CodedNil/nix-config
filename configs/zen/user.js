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
user_pref("zen.workspaces.open-new-tab-if-last-unpinned-tab-is-closed", false); // Prevents opening a new tab by default

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


/****************************************************************************
 * SECTION: FASTFOX                                                         *
****************************************************************************/
/** GENERAL ***/
user_pref("content.notify.interval", 100000);

/** GFX ***/
user_pref("gfx.canvas.accelerated.cache-items", 4096);
user_pref("gfx.canvas.accelerated.cache-size", 512);
user_pref("gfx.content.skia-font-cache-size", 20);

/** DISK CACHE ***/
user_pref("browser.cache.disk.enable", true);

/** MEDIA CACHE ***/
user_pref("media.memory_cache_max_size", 65536);
user_pref("media.cache_readahead_limit", 7200);
user_pref("media.cache_resume_threshold", 3600);

/** IMAGE CACHE ***/
user_pref("image.mem.decode_bytes_at_a_time", 32768);

/** NETWORK ***/
user_pref("network.http.max-connections", 1800);
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
user_pref("network.http.pacing.requests.enabled", false);
user_pref("network.dnsCacheExpiration", 3600);
user_pref("network.ssl_tokens_cache_capacity", 10240);

/** SPECULATIVE LOADING ***/
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.prefetch-next", false);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);

/** EXPERIMENTAL ***/
user_pref("layout.css.grid-template-masonry-value.enabled", true);
user_pref("dom.enable_web_task_scheduling", true);

/****************************************************************************
 * SECTION: SECUREFOX                                                       *
****************************************************************************/
/** TRACKING PROTECTION ***/
user_pref("browser.contentblocking.category", "strict");
user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.helperApps.deleteTempFileOnExit", true);
user_pref("browser.uitour.enabled", false);
user_pref("privacy.globalprivacycontrol.enabled", true);

/** OCSP & CERTS / HPKP ***/
user_pref("security.OCSP.enabled", 0);
user_pref("security.remote_settings.crlite_filters.enabled", true);
user_pref("security.pki.crlite_mode", 2);

/** SSL / TLS ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.tls.enable_0rtt_data", false);

/** DISK AVOIDANCE ***/
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("browser.sessionstore.interval", 60000);

/** SHUTDOWN & SANITIZING ***/
user_pref("browser.privatebrowsing.resetPBM.enabled", true);
user_pref("privacy.history.custom", true);

/** SEARCH / URL BAR ***/
user_pref("browser.urlbar.trimHttps", true);
user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.urlbar.update2.engineAliasRefresh", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("security.insecure_connection_text.pbmode.enabled", true);
user_pref("network.IDN_show_punycode", true);

/** HTTPS-FIRST POLICY ***/
user_pref("dom.security.https_first", true);

/** PASSWORDS ***/
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("editor.truncate_user_pastes", false);

/** MIXED CONTENT + CROSS-SITE ***/
user_pref("security.mixed_content.block_display_content", true);
user_pref("pdfjs.enableScripting", false);

/** EXTENSIONS ***/
user_pref("extensions.enabledScopes", 5);

/** HEADERS / REFERERS ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/** CONTAINERS ***/
user_pref("privacy.userContext.ui.enabled", true);

/** SAFE BROWSING ***/
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

/** MOZILLA ***/
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("browser.search.update", false);
user_pref("permissions.manager.defaultsUrl", "");

/** TELEMETRY ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

/** EXPERIMENTS ***/
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/** CRASH REPORTS ***/
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);

/** DETECTION ***/
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);

/****************************************************************************
 * SECTION: PESKYFOX                                                        *
****************************************************************************/
/** MOZILLA UI ***/
user_pref("browser.privatebrowsing.vpnpromourl", "");
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.profiles.enabled", true);

/** THEME ADJUSTMENTS ***/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

/** COOKIE BANNER HANDLING ***/
user_pref("cookiebanners.service.mode", 1);
user_pref("cookiebanners.service.mode.privateBrowsing", 1);

/** FULLSCREEN NOTICE ***/
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.timeout", 0);

/** URL BAR ***/
user_pref("browser.urlbar.suggest.calculator", true);
user_pref("browser.urlbar.unitConversion.enabled", true);
user_pref("browser.urlbar.trending.featureGate", false);

/** NEW TAB PAGE ***/
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showWeather", true);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

/** POCKET ***/
user_pref("extensions.pocket.enabled", false);

/** DOWNLOADS ***/
user_pref("browser.download.manager.addToRecentDocs", false);

/** PDF ***/
user_pref("browser.download.open_pdf_attachments_inline", true);

/** TAB BEHAVIOR ***/
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.menu.showViewImageInfo", true);
user_pref("findbar.highlightAll", true);
user_pref("layout.word_select.eat_space_to_next_word", false);

/****************************************************************************
 * SECTION: SMOOTHFOX                                                       *
****************************************************************************/
user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
user_pref("general.smoothScroll", true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", "2");
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
user_pref("general.smoothScroll.currentVelocityWeighting", "1");
user_pref("general.smoothScroll.stopDecelerationWeighting", "1");
user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking