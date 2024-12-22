# About

This plugin is a clone of https://github.com/matthiasweiss/angular-quickswitch.nvim, but I wanted it to function more like https://marketplace.visualstudio.com/items?itemName=erhise.vs-ng-quick-switch#:~:text=This%20extension%20for%20Visual%20Studio,template%20file%20for%20better%20productivity.

## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim)

```
{ "thischarmingsam8/angular-quickswitch.nvim", opts = { use_default_keymaps = true } }
```

## Usage

All of the following commands switch to one specific file:

| command                   | file                                                                     |
|---------------------------|--------------------------------------------------------------------------|
| `:NgQuickSwitchClass`     | Class, e.g. `example.component.ts`          |
| `:NgQuickSwitchTemplate`  | Template, e.g. `example.component.html`                             |
| `:NgQuickSwitchStyles`      | Styles, e.g. `example.component.scss` |

## Keymaps

Since calling the commands manually each time is quite cumbersome, I use the following keymaps:

| command                | keymap       |
|------------------------|--------------|
| `:NgQuickSwitchClass`     | `<leader>ac`          |
| `:NgQuickSwitchTemplate`  |  `<leader>at`                             |
| `:NgQuickSwitchStyles`  |  `<leader>as` |


If you don't want to use the same keymaps, you can remove `use_default_keymaps=true` as follows:

```
{ "thischarmingsam8/angular-quickswitch.nvim", opts = {} }
```

If you choose to specify your own keymaps, make sure to add `slient = true` to your keymap options to prevent the command modal from appearing during the switch.

## which-key

If you are using which-key, add this to your user plugin files to add a group for the keymappings:

```
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>a", group = "Angular" },
        },
      },
    },
  },
}
```


