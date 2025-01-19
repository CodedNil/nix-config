{
  lib,
  ...
}:

{
  # Update the discord settings.json
  home.activation.updateDiscordSettings = lib.hm.dag.entryAfter [ ] ''
    configFile="$HOME/.config/discord/settings.json"

    # Ensure the file exists
    [ ! -f "$configFile" ] && echo '{}' > "$configFile"

    tmpFile=$(mktemp)

    # Update or add the specified JSON fields
    jq '
      .SKIP_HOST_UPDATE = true |
      .MINIMIZE_TO_TRAY = false |
      .OPEN_ON_STARTUP = false |
      .openasar.setup = true |
      .openasar.noTrack = true |
      .openasar.quickstart = true
    ' "$configFile" > "$tmpFile" && mv "$tmpFile" "$configFile"

    rm -f "$tmpFile"
  '';

  # Add discord with plugins and openasar
  programs.nixcord =
    let
      equicordRepo = builtins.fetchGit {
        url = "https://github.com/Equicord/Equicord.git";
        rev = "4c332d81f403bffbc5dc664b4c1858639eba36ff";
      };
    in
    {
      enable = true;
      # Enable equicord plugins
      userPlugins = {
        betterActivities = "github:D3SOX/vc-betterActivities/b42afcd35d0ade108114b301859c7a077f45a8d5";
        betterQuickReact = "${equicordRepo}/src/equicordplugins/betterQuickReact";
        homeTyping = "${equicordRepo}/src/equicordplugins/homeTyping";
        # limitMiddleClickPaste = "${equicordRepo}/src/equicordplugins/limitMiddleClickPaste";
        messageLoggerEnhanced = "github:Syncxv/vc-message-logger-enhanced/199b24e32503c7d3288c5237ed0786d6ce10c855";
        messagePeek = "github:Domis-Vencord-Plugins/MessagePeek/4176cee88e7f47a25af5302196a185bf06b62a3d";
        # unreadCountBadge = "${equicordRepo}/src/equicordplugins/unreadCountBadge";
      };
      # Hide buttons on the chat bar
      quickCss = ''
        # [aria-label="Apps"] {
        #   display:none
        # }
        # [aria-label="Open GIF picker"] {
        #   display:none
        # }
        [aria-label="Open sticker picker"] {
          display:none
        }
        [aria-label="Send a gift"] {
          display:none
        }
        # [aria-label="Boost this server"] {
        #   display:none
        # }
        # [id="channel-attach-THREAD"] {
        #   display:none
        # }
        # div[class^="channelAppLauncher"] {
        #   display:none
        # }
      '';
      extraConfig = {
        plugins = {
          betterActivities = {
            enable = true;
            memberList = true;
            userPopout = true;
            specialFirst = true;
            iconSize = 15;
          };
          betterQuickReact = {
            enable = true;
            frequentEmojis = true;
            compactMode = true;
            scroll = false;
            columns = 4;
            rows = 2;
          };
          homeTyping.enable = true;
          # limitMiddleClickPaste.enable = true;
          messageLoggerEnhanced = {
            enable = true;
            saveMessages = true;
            saveImages = true;
            sortNewest = true;
            cacheMessagesFromServers = false;
            autoCheckForUpdates = true;
            ignoreBots = false;
            ignoreSelf = false;
            ignoreMutedGuilds = true;
            ignoreMutedCategories = false;
            ignoreMutedChannels = false;
            alwaysLogDirectMessages = true;
            alwaysLogCurrentChannel = true;
            permanentlyRemoveLogByDefault = false;
            hideMessageFromMessageLoggers = false;
            ShowLogsButton = true;
            messagesToDisplayAtOnceInLogs = 100;
            hideMessageFromMessageLoggersDeletedMessage = "redacted eh";
            messageLimit = 200;
            attachmentSizeLimitInMegabytes = 12;
            attachmentFileExtensions = "png,jpg,jpeg,gif,webp,mp4,webm,mp3,ogg,wav";
            cacheLimit = 1000;
            whitelistedIds = "567724019340541963";
            blacklistedIds = "";
            imageCacheDir = "/home/dan/.config/Vencord/MessageLoggerData/savedImages";
            logsDir = "/home/dan/.config/Vencord/MessageLoggerData";
          };
          messagePeek = {
            enable = true;
            dms = true;
            guildChannels = true;
          };
          # unreadCountBadge = {
          #   enable = true;
          #   replaceWhiteDot = false;
          #   showOnMutedChannels = false;
          # };
        };
      };
      config = {
        disableMinSize = true;
        useQuickCss = true;
        plugins = {
          alwaysTrust.enable = true;
          clearURLs.enable = true;
          crashHandler.enable = true;
          fakeNitro.enable = true;
          fullSearchContext.enable = true;
          memberCount.enable = true;
          mentionAvatars.enable = true;
          messageLogger = {
            enable = true;
            inlineEdits = false;
            collapseDeleted = false;
            deleteStyle = "text";
            logEdits = true;
            logDeletes = true;
            ignoreBots = false;
            ignoreSelf = false;
            ignoreUsers = "";
            ignoreChannels = "";
            ignoreGuilds = "";
          };
          noF1.enable = true;
          noTrack.enable = true;
          onePingPerDM.enable = true;
          petpet.enable = true;
          quickMention.enable = true;
          replyTimestamp.enable = true;
          roleColorEverywhere.enable = true;
          summaries = {
            enable = true;
            summaryExpiryThresholdDays = 7;
          };
          typingIndicator = {
            enable = true;
            includeMutedChannels = true;
            includeCurrentChannel = true;
            indicatorMode = "avatars";
            includeBlockedUsers = false;
          };
          typingTweaks.enable = true;
          userVoiceShow.enable = true;
          voiceMessages.enable = true;
          whoReacted.enable = true;
        };
      };
    };
}
