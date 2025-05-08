{ inputs, lib, ... }:

{
  programs.firefox = {
    enable = true;

    arkenfox = {
      enable = true;
    };

    profiles.user = {

      arkenfox = {
        enable = true;
        enableAllSections = true;
      };

      settings = {
	"dom.private-attribution.submission.enabled" = false;
        "identity.fxaccounts.enabled" = false;
	"gfx.webrender.all" = true;
	"media.ffmpeg.vaapi.enabled" = true;

	"extensions.pocket.enabled" = false;
	"extensions.autoDisableScopes" = 0;
	"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        "browser.tabs.inTitlebar" = 0;
        "browser.download.panel.shown" = true;
	"browser.sessionstore.resume_from_crash" = false;
	"browser.safebrowsing.malware.enabled" = false;
	"browser.safebrowsing.phishing.enabled" = false;
	"browser.safebrowsing.downloads.enabled" = false;

	"browser.startup.page" = lib.mkForce 1;
	"browser.newtabpage.enabled" = lib.mkForce true;
	"browser.startup.homepage" = lib.mkForce "about:home";
      };                                  

      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
      ];
    };
  };
}
