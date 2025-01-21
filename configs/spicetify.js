(function () {
    // Helper function to update local storage
    function updateLocalStorage(key, newData) {
        localStorage.setItem(key, JSON.stringify(newData));
    }

    // Update experimental features
    const expFeaturesKey = "com.spotify.single.item.cache:desktop-ui";
    let expFeatures = JSON.parse(localStorage.getItem(expFeaturesKey) || "{}");
    expFeatures.value = expFeatures.value || {};
    expFeatures.value.enableQueueOnRightPanel = false; // Enable Queue on the right panel
    expFeatures.value.enableRightSidebarLyrics = true; // Show lyrics in the right sidebar
    expFeatures.value.enableSmartShuffle = true; // Enable Smart Shuffle
    expFeatures.value.enableNewShuffleModeOrder = true; // Enable new Shuffle Mode order where Smart Shuffle comes before normal Shuffle
    updateLocalStorage(expFeaturesKey, expFeatures);

    // Override starRatings settings
    updateLocalStorage("starRatings:settings", {
        halfStarRatings: true,
        likeThreshold: "3.0",
        hideHearts: false,
        enableKeyboardShortcuts: true,
        showPlaylistStars: true,
        nowPlayingStarsPosition: "left",
        skipThreshold: "disabled"
    });

    // Override shufflePlus settings
    updateLocalStorage("shufflePlus:settings", {
        artistMode: "all",
        artistNameMust: false,
        enableQueueButton: true
    });

    // Update specific parts of lucid-settings
    const lucidSettingsKey = "lucid-settings";
    if (localStorage.getItem(lucidSettingsKey)) {
        const lucidSettings = JSON.parse(localStorage.getItem(lucidSettingsKey) || "{}");
    
        // Helper function to safely access or initialize an object by key
        function setNestedProperty(obj, path, value) {
            path.split('.').reduce((acc, key, index, array) => {
              if (index === array.length - 1) {
                acc[key] = value; // Set the final value
              } else {
                acc[key] = acc[key] || {}; // Ensure the object exists
              }
              return acc[key];
            }, obj);
        }
        setNestedProperty(lucidSettings, 'state.backgroundSettings.mode', 'animated');
        setNestedProperty(lucidSettings, 'state.backgroundSettings.styles.animated', {
          "blur": 64, // 32
          "time": 40, // 45
          "opacity": 1, // 1
          "saturation": 1.3, // 1.1
          "contrast": 1.15, // 1.2
          "brightness": 0.6 // 0.475
        });
        setNestedProperty(lucidSettings, 'state.colorSettings.isDynamicColor', true);
        setNestedProperty(lucidSettings, 'state.interfaceSettings.pagesSettings.backgroundImageMode', 'none');
        setNestedProperty(lucidSettings, 'state.interfaceSettings.pagesSettings.playlistViewMode', 'compact');
        updateLocalStorage(lucidSettingsKey, lucidSettings);
    }
})();