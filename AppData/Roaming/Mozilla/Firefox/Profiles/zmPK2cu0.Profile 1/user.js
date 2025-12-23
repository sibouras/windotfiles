// https://github.com/yokoffing/Betterfox/blob/main/Peskyfox.js

/****************************************************************************
 * SECTION: my_prefs                                                        *
 ****************************************************************************/
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);
user_pref("datareporting.usage.uploadEnabled", false);
user_pref("privacy.sanitize.cpd.hasMigratedToNewPrefs3", true);
user_pref("browser.urlbar.shortcuts.actions", false);
user_pref("browser.urlbar.shortcuts.bookmarks", false);
user_pref("browser.urlbar.shortcuts.history", false);
user_pref("browser.urlbar.shortcuts.tabs", false);
user_pref("privacy.userContext.enabled", true); // enable container tabs
user_pref("privacy.userContext.ui.enabled", true); // show container tabs in settings

/****************************************************************************
 * SECTION: Securefox                                                        *
 ****************************************************************************/
user_pref("browser.contentblocking.category", "strict"); // [HIDDEN PREF]

/** SEARCH / URL BAR ***/
user_pref("browser.urlbar.trimHttps", true);
user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("network.IDN_show_punycode", true);

/** HTTPS-ONLY MODE ***/
user_pref("dom.security.https_only_mode", true);
// PREF: offer suggestion for HTTPS site when available
// [1] https://x.com/leli_gibts_scho/status/1371463866606059528
user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

/****************************************************************************
 * SECTION: PESKYFOX                                                        *
 ****************************************************************************/

/** MOZILLA UI ***/
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);

// PREF: new profile switcher
// user_pref("browser.profiles.enabled", true); // default=false

// PREF: Allow Firefox to use userChome, userContent, etc.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// PREF: Disable built-in Pocket extension
user_pref("extensions.pocket.enabled", false);

// PREF: Disable Accessibility services
// Performance improvement
// user_pref("accessibility.force_disabled", 1);
// user_pref("devtools.accessibility.enabled", false);

/** FULLSCREEN ***/
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);

/** NEW TAB PAGE ***/
user_pref("browser.newtabpage.activity-stream.topSitesRows", 2);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);

// limit fullscreen to browser window
user_pref("full-screen-api.ignore-widgets", true); // default=false

// zoom with alt+wheel
user_pref("mousewheel.with_alt.action", 5); // default=2

/** AI ***/
user_pref("browser.tabs.groups.smart.userEnabled", false);
user_pref("browser.ml.linkPreview.collapsed", true);

/****************************************************************************
 * SECTION: URL BAR                                                         *
 ****************************************************************************/

// PREF: adjust the amount of Address bar / URL bar dropdown results
// This value controls the total number of entries to appear in the location bar dropdown.
// [NOTE] Items (bookmarks/history/openpages) with a high "frequency"/"bonus" will always
// be displayed (no we do not know how these are calculated or what the threshold is),
// and this does not affect the search by search engine suggestion.
// disable=0
user_pref("browser.urlbar.maxRichResults", 12); // default=10

// remove `Add tab to taskbar` icon
user_pref("browser.taskbarTabs.enabled", false); // default=true

/******************************************************************************
 * SECTION: DOWNLOADS                                 *
 ******************************************************************************/

// PREF: choose download location
// [SETTING] To set your default "downloads": General>Downloads>Save files to...
// 0=desktop, 1=downloads (default), 2=last used
//user_pref("browser.download.folderList", 1);

// PREF: Enforce user interaction for security by always asking where to download.
// [SETTING] General>Downloads>Always ask you where to save files
// false=the user is asked what to do
user_pref("browser.download.useDownloadDir", false);

// PREF: disable downloads panel opening on every download
user_pref("browser.download.alwaysOpenPanel", false);

// PREF: Disable adding downloads to the system's "recent documents" list
user_pref("browser.download.manager.addToRecentDocs", false);

// PREF: Autohide download button
//user_pref("browser.download.autohideButton", true); // DEFAULT

// PREF: enable user interaction for security by always asking how to handle new mimetypes
// [SETTING] General>Files and Applications>What should Firefox do with other files
user_pref("browser.download.always_ask_before_handling_new_types", true);

// PREF: autohide the downloads button
//user_pref("browser.download.autohideButton", true); // DEFAULT

/****************************************************************************
 * SECTION: TAB BEHAVIOR                                                    *
 ****************************************************************************/

// PREF: restore "View image info" on right-click
user_pref("browser.menu.showViewImageInfo", true);

// PREF: enable Tab Previews [FF122+, FF128+]
// user_pref("browser.tabs.hoverPreview.enabled", true); // default=true
user_pref("browser.tabs.hoverPreview.showThumbnails", false); // default=true

/****************************************************************************
 * SECTION: KEYBOARD AND SHORTCUTS                                          *
 ****************************************************************************/

// PREF: Disable ALT key toggling the menu bar
//user_pref("ui.key.menuAccessKey", 0);
user_pref("ui.key.menuAccessKeyFocuses", false); // default=true

// PREF: cycle through tabs in recently used order
// [SETTING] Ctrl+Tab cycles through tabs in recently used order
user_pref("browser.ctrlTab.sortByRecentlyUsed", true); // default=false

// PREF: disable websites overriding Firefox's keyboard shortcuts [FF58+]
// 0=ask (default), 1=allow, 2=block
// [SETTING] to add site exceptions: Ctrl+I>Permissions>Override Keyboard Shortcuts ***/
//user_pref("permissions.default.shortcuts", 2);

/****************************************************************************
 * SECTION: BOOKMARK MANAGEMENT                                             *
 ****************************************************************************/

// PREF: limit the number of bookmark backups Firefox keeps
//user_pref("browser.bookmarks.max_backups", 1); // default=15

/****************************************************************************
 * SECTION: ZOOM AND DISPLAY SETTINGS                                       *
 ****************************************************************************/

// PREF: zoom only text on webpage, not other elements
//user_pref("browser.zoom.full", false);

// PREF: allow for more granular control of zoom levels
// Especially useful if you want to set your default zoom to a custom level.
// This does not seem to work for Ctrl+Wheel
// biome-ignore format: do not format this line, firefox doesn't parse the trailing comma
user_pref("toolkit.zoomManager.zoomValues", ".3,.5,.67,.8,.9,1,1.05,1.1,1.15,1.2,1.25,1.3,1.35,1.4,1.45,1.5,1.7,2,2.4,3,4,5");

// PREF: adjust the minimum tab width
// Can be overridden by userChrome.css
user_pref("browser.tabs.tabMinWidth", 90); // default=76

// PREF: always underline links [FF120+]
//user_pref("layout.css.always_underline_links", false); // DEFAULT

/****************************************************************************
 * SECTION: TRACKING PROTECTION                                             *
 ****************************************************************************/
// https://github.com/yokoffing/Betterfox/blob/main/Securefox.js

/******************************************************************************
 * SECTION: SEARCH / URL BAR                                                 *
 ******************************************************************************/

// PREF: trim HTTPS from the URL bar [FF119+]
// Firefox will hide https:// from the address bar, but not subdomains like www.
// It saves some space. Betterfox already uses HTTPS-by-Default and insecure sites
// get a padlock with a red stripe. Copying the URL still copies the scheme,
// so it's not like we need to see https. It's not a privacy issue, so you can add to your overrides.
// [TEST] http://www.http2demo.io/
// [1] https://www.ghacks.net/2023/09/19/firefox-119-will-launch-with-an-important-address-bar-change/
user_pref("browser.urlbar.trimHttps", true); // default=false
user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true); // default=false

/******************************************************************************
 * SECTION: TELEMETRY                                                   *
 ******************************************************************************/
// Disable all the various Mozilla telemetry, studies, reports, etc.

// PREF: Telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);

// PREF: Corroborator
//user_pref("corroborator.enabled", false);

// PREF: Telemetry Coverage
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
//user_pref("toolkit.coverage.endpoint.base", "");

// PREF: Health Reports
// [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to send technical data.
user_pref("datareporting.healthreport.uploadEnabled", false);

// PREF: new data submission, master kill switch
// If disabled, no policy is shown or upload takes place, ever
// [1] https://bugzilla.mozilla.org/1195552
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// PREF: Studies
// [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to install and run studies
user_pref("app.shield.optoutstudies.enabled", false);

// Personalized Extension Recommendations in about:addons and AMO
// [NOTE] This pref has no effect when Health Reports are disabled.
// [SETTING] Privacy & Security>Firefox Data Collection & Use>Allow Firefox to make personalized extension recommendations
user_pref("browser.discovery.enabled", false);

// PREF: disable crash reports
// user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
//user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // DEFAULT
// PREF: backlogged crash reports
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

// PREF: Captive Portal detection
// [WARNING] Do NOT use for mobile devices. May NOT be able to use Firefox on public wifi (hotels, coffee shops, etc).
// [1] https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy
// [2] https://wiki.mozilla.org/Necko/CaptivePortal
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);

// PREF: Network Connectivity checks
// [WARNING] Do NOT use for mobile devices. May NOT be able to use Firefox on public wifi (hotels, coffee shops, etc).
// [1] https://bugzilla.mozilla.org/1460537
user_pref("network.connectivity-service.enabled", false);

// PREF: software that continually reports what default browser you are using
user_pref("default-browser-agent.enabled", false);

// PREF: "report extensions for abuse"
//user_pref("extensions.abuseReport.enabled", false);

// PREF: Normandy/Shield [extensions tracking]
// Shield is an telemetry system (including Heartbeat) that can also push and test "recipes"
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// PREF: PingCentre telemetry (used in several System Add-ons)
// Currently blocked by 'datareporting.healthreport.uploadEnabled'
user_pref("browser.ping-centre.telemetry", false);

// PREF: disable Firefox Home (Activity Stream) telemetry
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
