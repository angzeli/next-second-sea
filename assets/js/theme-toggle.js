(function () {
  var storageKey = "theme";
  var root = document.documentElement;
  var query = window.matchMedia ? window.matchMedia("(prefers-color-scheme: dark)") : null;
  var lightThemeColor = document.querySelector('[data-theme-color="light"]');
  var darkThemeColor = document.querySelector('[data-theme-color="dark"]');

  function readSavedTheme() {
    try {
      var value = window.localStorage.getItem(storageKey);
      return value === "light" || value === "dark" ? value : null;
    } catch (error) {
      return null;
    }
  }

  function saveTheme(theme) {
    try {
      window.localStorage.setItem(storageKey, theme);
    } catch (error) {
      return;
    }
  }

  function systemTheme() {
    return query && query.matches ? "dark" : "light";
  }

  function updateThemeColor(theme, hasManualChoice) {
    if (!lightThemeColor || !darkThemeColor) {
      return;
    }

    if (!hasManualChoice) {
      lightThemeColor.setAttribute("media", "(prefers-color-scheme: light)");
      darkThemeColor.setAttribute("media", "(prefers-color-scheme: dark)");
      return;
    }

    lightThemeColor.setAttribute("media", theme === "light" ? "all" : "not all");
    darkThemeColor.setAttribute("media", theme === "dark" ? "all" : "not all");
  }

  function updateButtons(theme) {
    var buttons = document.querySelectorAll("[data-theme-choice]");

    buttons.forEach(function (button) {
      var isActive = button.dataset.themeChoice === theme;
      button.classList.toggle("is-active", isActive);
      button.setAttribute("aria-pressed", isActive ? "true" : "false");
    });
  }

  function applyTheme(theme, hasManualChoice) {
    root.dataset.theme = theme;
    root.style.colorScheme = theme;
    updateThemeColor(theme, hasManualChoice);
    updateButtons(theme);
  }

  function init() {
    var savedTheme = readSavedTheme();

    applyTheme(savedTheme || systemTheme(), Boolean(savedTheme));

    document.querySelectorAll("[data-theme-choice]").forEach(function (button) {
      button.addEventListener("click", function () {
        var theme = button.dataset.themeChoice;

        if (theme !== "light" && theme !== "dark") {
          return;
        }

        saveTheme(theme);
        applyTheme(theme, true);
      });
    });

    if (query) {
      var onSystemThemeChange = function () {
        if (!readSavedTheme()) {
          applyTheme(systemTheme(), false);
        }
      };

      if (query.addEventListener) {
        query.addEventListener("change", onSystemThemeChange);
      } else if (query.addListener) {
        query.addListener(onSystemThemeChange);
      }
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
}());
