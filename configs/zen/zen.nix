{ config, pkgs, ... }:

let
  # Fetch the entire theme store repository
  themeStoreRepo = pkgs.fetchFromGitHub {
    owner = "zen-browser";
    repo = "theme-store";
    rev = "main";
  };

  # Base directory within the theme store
  themeBaseDir = "${themeStoreRepo}/themes";

  # Function to gather theme CSS and generate import statements
  gatherThemeData =
    {
      id,
      name,
      preferences ? true,
    }:
    {
      cssImportLine = "@import url(\"file://${config.home.homeDirectory}/.zen/profiletest.default/chrome/zen-themes/${name}/chrome.css\");";
      files =
        [
          {
            source = "${themeBaseDir}/${id}/chrome.css";
            target = ".zen/profiletest.default/chrome/zen-themes/${name}/chrome.css";
          }
          {
            source = "${themeBaseDir}/${id}/readme.md";
            target = ".zen/profiletest.default/chrome/zen-themes/${name}/readme.md";
          }
        ]
        ++ (
          if preferences then
            [
              {
                source = "${themeBaseDir}/${id}/preferences.json";
                target = ".zen/profiletest.default/chrome/zen-themes/${name}/preferences.json";
              }
            ]
          else
            [ ]
        );
    };

  # List of themes
  themes = [
    {
      id = "f50841b2-5e4a-4534-985d-b7f7b96088c2";
      name = "NoHighlightSplit";
    }
    {
      id = "906c6915-5677-48ff-9bfc-096a02a72379";
      name = "Floating Status Bar";
    }
    {
      id = "d7076c31-f6c1-4f28-b2e8-15b95f5a3d6f";
      name = "No Search Shortcut Icons";
    }
    {
      id = "664c54f9-d97d-410b-a479-23dd8a08a628";
      name = "Better Tab Indicators";
      preferences = true;
    }
    {
      id = "cfa711cf-e9f7-4c35-8289-3e7633f93565";
      name = "Fluid URL";
      preferences = true;
    }
    {
      id = "4596d8f9-f0b7-4aeb-aa92-851222dc1888";
      name = "Only Close On Hover";
    }
    {
      id = "ad97bb70-0066-4e42-9b5f-173a5e42c6fc";
      name = "SuperPins";
      preferences = true;
    }
    {
      id = "d93e67f8-e5e1-401e-9b82-f9d5bab231e6";
      name = "Super Url Bar";
      preferences = true;
    }
    {
      id = "f4866f39-cfd6-4498-ab92-54213b8279dc";
      name = "Animations Plus";
    }
    {
      id = "fd24f832-a2e6-4ce9-8b19-7aa888eb7f8e";
      name = "Quietify";
    }
    {
      id = "1e86cf37-a127-4f24-b919-d265b5ce29a0";
      name = "Cleaner Extension Menu";
    }
    {
      id = "a6335949-4465-4b71-926c-4a52d34bc9c0";
      name = "Better Find Bar";
    }
    {
      id = "87196c08-8ca1-4848-b13b-7ea41ee830e7";
      name = "Tab Preview Enhanced";
    }
    {
      id = "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24";
      name = "Load Bar";
    }
    {
      id = "253a3a74-0cc4-47b7-8b82-996a64f030d5";
      name = "Floating History";
    }
  ];

  # Process theme data to extract file mappings and CSS imports
  processedThemes = map gatherThemeData themes;

  # Combine all import statements into a single CSS text
  cssImportText = builtins.concatStringsSep "\n" (map (theme: theme.cssImportLine) processedThemes);

  # Merge all theme file configurations
  themeFileEntries = builtins.foldl' (
    acc: theme:
    acc
    // builtins.listToAttrs (
      map (file: {
        name = replaceStrings [ "." ] [ "_" ] file.target;
        value = {
          enable = true;
          force = true;
          source = file.source;
          target = file.target;
        };
      }) theme.files
    )
  ) { } processedThemes;

in
{
  home.file = {
    zen_profiles = {
      enable = true;
      text = ./configs/zen/profiles.ini;
      target = ".zen/profilestest.ini";
    };
    zen_profile = {
      enable = true;
      source = ./configs/zen/user.js;
      target = ".zen/profiletest.default/user.js";
    };
    zen_themes_json = {
      enable = true;
      source = ./configs/zen/zen-themes.json;
      target = ".zen/profiletest.default/zen-themes.json";
    };
  } // themeFileEntries;
}
