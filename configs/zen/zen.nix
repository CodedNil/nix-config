{
  config,
  pkgs,
  lib,
  ...
}:

let
  # Fetch the entire theme store repository
  themeStoreRepo = pkgs.fetchFromGitHub {
    owner = "zen-browser";
    repo = "theme-store";
    rev = "dcbff62ade1eeacd831390f9ecff1535b65788bbhere";
    sha256 = "sha256-wa+wQ7oZNUHzmq0zgNSpx3o4Vc/O5IWjSCQpPtVcKtI=";
  };

  # Base directory within the theme store
  themeBaseDir = "${themeStoreRepo}/themes";

  # Base path for the profiles
  profileBasePath = ".zen/profile.default";

  # Function to gather theme CSS and generate import statements
  gatherThemeData =
    id: name: preferences:
    let
      transformedName = lib.toLower (builtins.replaceStrings [ " " ] [ "_" ] name);
    in
    {
      cssImportLine = "@import url(\"file://${config.home.homeDirectory}/${profileBasePath}/chrome/zen-themes/${name}/chrome.css\");";
      files =
        [
          {
            source = "${themeBaseDir}/${id}/chrome.css";
            target = "${profileBasePath}/chrome/zen-themes/${transformedName}/chrome.css";
          }
          {
            source = "${themeBaseDir}/${id}/readme.md";
            target = "${profileBasePath}/chrome/zen-themes/${transformedName}/readme.md";
          }
        ]
        ++ (
          if preferences then
            [
              {
                source = "${themeBaseDir}/${id}/preferences.json";
                target = "${profileBasePath}/chrome/zen-themes/${transformedName}/preferences.json";
              }
            ]
          else
            [ ]
        );
    };

  # List of themes
  themes = [
    (gatherThemeData "f4866f39-cfd6-4498-ab92-54213b8279dc" "Animations Plus" false)
    (gatherThemeData "a6335949-4465-4b71-926c-4a52d34bc9c0" "Better Find Bar" false)
    (gatherThemeData "664c54f9-d97d-410b-a479-23dd8a08a628" "Better Tab Indicators" true)
    (gatherThemeData "1e86cf37-a127-4f24-b919-d265b5ce29a0" "Cleaner Extension Menu" false)
    (gatherThemeData "253a3a74-0cc4-47b7-8b82-996a64f030d5" "Floating History" false)
    (gatherThemeData "906c6915-5677-48ff-9bfc-096a02a72379" "Floating Status Bar" false)
    (gatherThemeData "cfa711cf-e9f7-4c35-8289-3e7633f93565" "Fluid URL" true)
    (gatherThemeData "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24" "Load Bar" false)
    (gatherThemeData "f50841b2-5e4a-4534-985d-b7f7b96088c2" "NoHighlightSplit" false)
    (gatherThemeData "d7076c31-f6c1-4f28-b2e8-15b95f5a3d6f" "No Search Shortcut Icons" false)
    (gatherThemeData "4596d8f9-f0b7-4aeb-aa92-851222dc1888" "Only Close On Hover" false)
    (gatherThemeData "fd24f832-a2e6-4ce9-8b19-7aa888eb7f8e" "Quietify" false)
    (gatherThemeData "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" "SuperPins" true)
    (gatherThemeData "d93e67f8-e5e1-401e-9b82-f9d5bab231e6" "Super Url Bar" true)
    (gatherThemeData "87196c08-8ca1-4848-b13b-7ea41ee830e7" "Tab Preview Enhanced" false)
  ];

  # Combine all import statements into a single CSS text
  cssImportText = builtins.concatStringsSep "\n" (map (theme: theme.cssImportLine) themes);

  # Merge all theme file configurations
  themeFileEntries = builtins.foldl' (
    acc: theme:
    acc
    // builtins.listToAttrs (
      map (file: {
        name = builtins.replaceStrings [ "." ] [ "_" ] file.target;
        value = {
          enable = true;
          force = true;
          source = file.source;
          target = file.target;
        };
      }) theme.files
    )
  ) { } themes;

in
{
  home.file = {
    zen_profiles = {
      enable = true;
      source = ./profiles.ini;
      target = ".zen/profiles.ini";
      force = true;
    };
    zen_user_js = {
      enable = true;
      source = ./user.js;
      target = "${profileBasePath}/user.js";
      force = true;
    };
    zen_themes_json = {
      enable = true;
      source = ./zen-themes.json;
      target = "${profileBasePath}/zen-themes.json";
      force = true;
    };
    zen_themes_css = {
      enable = true;
      text = cssImportText;
      target = "${profileBasePath}/chrome/zen-themes.css";
      force = true;
    };
  } // themeFileEntries;
}
