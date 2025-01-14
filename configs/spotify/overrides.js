
(function () {
    // Helper function to safely access or initialize an object by key
    function ensureObject(obj, key) {
        if (!(key in obj) || typeof obj[key] !== 'object' || obj[key] === null) {
            obj[key] = {};
        }
        return obj[key];
    }
    
    // Helper function to update local storage
    function updateLocalStorage(key, newData) {
        Spicetify.LocalStorage.set(key, JSON.stringify(newData));
    }

    // Update specific keys in spicetify-exp-features
    const expFeaturesKey = "spicetify-exp-features";
    let expFeatures = JSON.parse(Spicetify.LocalStorage.get(expFeaturesKey) || "{}");
    expFeatures.enableQueueOnRightPanel = {
        description: "Enable Queue on the right panel.",
        value: false
    };
    expFeatures.enableSmartShuffle = {
        description: "Enable Smart Shuffle",
        value: false
    };
    expFeatures.enableCanvasNpv = {
        description: "Enables short, looping visuals on tracks.",
        value: "canvas-play-loop",
        values: [
            "canvas-play-loop",
            "canvas-play-on-hover",
            "control"
        ]
    };
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
    const lucidSettings = JSON.parse(Spicetify.LocalStorage.get(lucidSettingsKey) || "{}");

    const state = ensureObject(lucidSettings, "state");
    const backgroundSettings = ensureObject(state, "backgroundSettings");
    const styles = ensureObject(backgroundSettings, "styles");
    const animated = ensureObject(styles, "animated");
    const interfaceSettings = ensureObject(state, "interfaceSettings");
    const pagesSettings = ensureObject(interfaceSettings, "pagesSettings");
    const colorSettings = ensureObject(state, "colorSettings");

    backgroundSettings.mode = "animated";
    animated.blur = 64;
    pagesSettings.backgroundImageMode = "none";
    pagesSettings.playlistViewMode = "compact";
    colorSettings.isDynamicColor = false;

    updateLocalStorage(lucidSettingsKey, lucidSettings);
})();