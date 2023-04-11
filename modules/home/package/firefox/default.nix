{ pkgs, ... }:
{
  programs.firefox =
    let
      userChrome = pkgs.substituteAll {
        src = ./userChrome.css;
      };
    in
    {
      enable = true;
      profiles.default = {
        userChrome = builtins.readFile userChrome;
      };
      package = with pkgs;
        wrapFirefox firefox-beta-bin-unwrapped {
          extraPolicies = {
            CaptivePortal = false;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DisableFirefoxAccounts = false;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            OfferToSaveLoginsDefault = false;
            PasswordManagerEnabled = false;
            UserMessaging = {
              ExtensionRecommendations = false;
              SkipOnboarding = true;
            };
            FirefoxHome = {
              Search = true;
              Pocket = false;
              Snippets = false;
              TopSites = false;
              Highlights = false;
            };

            Preferences = {
              "browser.toolbars.bookmarks.visibility" = "never";
              "privacy.webrtc.legacyGlobalIndicator" = false;
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            };
          };
        };
    };
}

