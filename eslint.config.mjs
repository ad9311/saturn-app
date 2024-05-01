import globals from "globals";
import pluginJs from "@eslint/js";


export default [
  {
    ignores: ["config/tailwind.config.js"],
  },
  {
    languageOptions: { globals: globals.browser },
    rules: {
      semi: [2, "never"],
      indent: ["error", 2],
      "no-unused-vars": ["error"],
      "no-empty-function": ["error"],
      "no-confusing-arrow": ["error"],
      quotes: ["error", "single"]
    }
  },
  pluginJs.configs.recommended,
];
