'use strict';
// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.
module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',
    // default font size in pixels for all tabs
    fontSize: 14,
    // font family with optional fallbacks
    fontFamily:
      '"Hack Nerd Font", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',
    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',
    // line height as a relative unit
    lineHeight: 1,
    // letter spacing as a relative unit
    letterSpacing: 0,
    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: '#4ade80', // Luminous green (Gmork's eyes)
    // terminal text color under BLOCK cursor
    cursorAccentColor: '#0a0a12', // Void
    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',
    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,
    // color of the text
    foregroundColor: '#f4f4f5', // Fang white - slightly warm
    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: '#0a0a12', // Void - deep blue-black (Gmork's fur)
    // terminal selection color
    selectionColor: 'rgba(42, 42, 54, 0.8)', // Cave stone with transparency
    // border color (window, tabs)
    borderColor: '#12121a', // Shadow (blue-black)
    // custom CSS to embed in the main window
    css: `
      /* Gmork Theme - Tab Bar & Window Chrome */
      .header_header {
        background: linear-gradient(180deg, #12121a 0%, #0a0a12 100%) !important;
        border-bottom: 1px solid #2a2a36 !important;
      }
      .tabs_nav {
        background: transparent !important;
      }
      .tab_tab {
        background: #12121a !important;
        border: none !important;
        color: #71717a !important;
        transition: all 0.2s ease !important;
      }
      .tab_tab:hover {
        background: #1c1c26 !important;
        color: #a1a1aa !important;
      }
      .tab_active {
        background: linear-gradient(180deg, #1c1c26 0%, #0a0a12 100%) !important;
        border-bottom: 2px solid #4ade80 !important;
        color: #f4f4f5 !important;
      }
      .tab_active::before {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 2px;
        background: #4ade80;
        box-shadow: 0 0 10px #4ade80, 0 0 20px rgba(74, 222, 128, 0.5);
      }
      .tab_icon {
        color: #71717a !important;
      }
      .tab_icon:hover {
        color: #dc2626 !important;
      }
      .tab_active .tab_icon:hover {
        color: #ef4444 !important;
      }
      /* Subtle glow on window focus */
      .hyper_main {
        border: 1px solid #12121a !important;
      }
      .hyper_main.isFocused_focused {
        border: 1px solid #2a2a36 !important;
        box-shadow: 0 0 30px rgba(74, 222, 128, 0.1) !important;
      }
      /* Style the + new tab button */
      .tab_tab.tab_new {
        color: #3edd78 !important;
      }
      .tab_tab.tab_new:hover {
        color: #4ade80 !important;
        text-shadow: 0 0 8px rgba(74, 222, 128, 0.6);
      }
    `,
    // custom CSS to embed in the terminal window
    termCSS: `
      /* Subtle text rendering improvements */
      x-screen {
        -webkit-font-smoothing: antialiased;
      }
    `,
    // set custom startup directory (must be an absolute path)
    workingDirectory: '',
    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',
    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',
    // custom padding (CSS format, i.e.: `top right bottom left`)
    // padding: "12px 14px",
    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object

    // GMORK COLOR PALETTE
    // Inspired by the black wolf from The NeverEnding Story
    // A dark, atmospheric theme with luminous green eyes in blue-black darkness
    colors: {
      black: '#12121a',          // Shadow (blue-black)
      red: '#dc2626',            // Blood crimson
      green: '#3edd78',          // Luminous green (Gmork's eyes)
      yellow: '#ea580c',         // Ember orange
      blue: '#7c3aed',           // Lightning purple (The Nothing)
      magenta: '#4c1d95',        // Void purple (The Nothing)
      cyan: '#22d3ee',           // Pale cyan
      white: '#f4f4f5',          // Fang white
      lightBlack: '#2a2a36',     // Cave stone
      lightRed: '#ef4444',       // Bright blood
      lightGreen: '#4ade80',     // Eye shine
      lightYellow: '#f97316',    // Bright ember
      lightBlue: '#a78bfa',      // Bright purple
      lightMagenta: '#7c3aed',   // Lightning purple
      lightCyan: '#67e8f9',      // Lightning flash
      lightWhite: '#fafafa',     // Bright fang
    },
    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Windows Subsystem for Linux (WSL) - previously Bash on Windows
    // - Example: `C:\\Windows\\System32\\wsl.exe`
    //
    // Git-bash on Windows
    // - Example: `C:\\Program Files\\Git\\bin\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    //
    // Cygwin
    // - Example: `C:\\cygwin64\\bin\\bash.exe`
    shell: '',
    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ['--login'],
    // for environment variables
    env: {},
    // Supported Options:
    //  1. 'SOUND' -> Enables the bell as a sound
    //  2. false: turns off the bell
    bell: 'SOUND',
    // An absolute file path to a sound file on the machine.
    // bellSoundURL: '/path/to/sound/file',
    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,
    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,
    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,
    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: 'force',
    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: false,
    // keypress required for weblink activation: [ctrl|alt|meta|shift]
    // todo: does not pick up config changes automatically, need to restart terminal :/
    webLinksActivationKey: '',
    // if `false` (without backticks and without quotes), Hyper will use ligatures provided by some fonts
    disableLigatures: false,
    // set to true to disable auto updates
    disableAutoUpdates: false,
    // for advanced config flags please refer to https://hyper.is/#cfg
  },
  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: ['hyper-font-ligatures'],
  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};
//# sourceMappingURL=config-default.js.map
