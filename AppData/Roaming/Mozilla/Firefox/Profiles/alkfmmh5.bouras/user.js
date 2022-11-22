/****************************************************************************
 * SECTION: PESKYFOX                                                        *
 ****************************************************************************/

// PREF: Allow Firefox to use userChome, userContent, etc.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// PREF: Disable Accessibility services
// Performance improvement
// user_pref("accessibility.force_disabled", 1);
// user_pref("devtools.accessibility.enabled", false);

/** FULLSCREEN ***/
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);

// PREF: Disable built-in Pocket extension
user_pref("extensions.pocket.enabled", false);

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

// PREF: Disable ALT key toggling the menu bar
//user_pref("ui.key.menuAccessKey", 0);
user_pref("ui.key.menuAccessKeyFocuses", false);

/****************************************************************************
 * SECTION: TRACKING PROTECTION                                             *
 ****************************************************************************/

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
