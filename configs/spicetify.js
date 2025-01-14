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

    // // Update specific parts of lucid-settings
    // const lucidSettingsKey = "lucid-settings";
    // const lucidSettings = JSON.parse(localStorage.getItem(lucidSettingsKey) || "{}");

    // // Helper function to safely access or initialize an object by key
    // function ensureObject(obj, key) {
    //     if (!(key in obj) || typeof obj[key] !== 'object' || obj[key] === null) {
    //         obj[key] = {};
    //     }
    //     return obj[key];
    // }
    // const state = ensureObject(lucidSettings, "state");
    // const backgroundSettings = ensureObject(state, "backgroundSettings");
    // const styles = ensureObject(backgroundSettings, "styles");
    // const animated = ensureObject(styles, "animated");
    // const interfaceSettings = ensureObject(state, "interfaceSettings");
    // const pagesSettings = ensureObject(interfaceSettings, "pagesSettings");
    // const colorSettings = ensureObject(state, "colorSettings");

    // backgroundSettings.mode = "animated";
    // animated.blur = 64;
    // pagesSettings.backgroundImageMode = "none";
    // pagesSettings.playlistViewMode = "compact";
    // colorSettings.isDynamicColor = true;

    // updateLocalStorage(lucidSettingsKey, lucidSettings);
})();