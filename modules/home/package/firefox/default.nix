{ config, pkgs, theme, inputs, ... }:

{
  programs.firefox =
    let
      userChrome = pkgs.substituteAll {
        src = ./userChrome.css;
      };
    in
    {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          CaptivePortal = false;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          FirefoxHome = {
            Search = false;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
        };
      };
      profiles = {
        default = {
          id = 0;
          name = "fahim";
          search = {
            force = true;
            default = "DashDuckGO";
            engines = {
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@nw" ];
              };
              "Wikipedia (en)".metaData.alias = "@wiki";
              "Google".metaData.hidden = true;
              "Amazon.com".metaData.hidden = true;
              "Bing".metaData.hidden = true;
              "eBay".metaData.hidden = true;
            };
          };
          settings = {
            "general.smoothScroll" = true;
            "browser.toolbars.bookmarks.visibility" = "never";
            "privacy.webrtc.legacyGlobalIndicator" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.compactmode.show" = true;
            "full-screen-api.ignore-widgets" = false;
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            duckduckgo-privacy-essentials
            languagetool
            news-feed-eradicator
          ];
          userChrome = builtins.readFile userChrome;
        };
      };
    };
}
