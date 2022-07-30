import { defineConfig } from "vite";

import { fileURLToPath, URL } from "node:url";
import path from "path";

import vue from "@vitejs/plugin-vue";
import { VitePWA } from "vite-plugin-pwa";
import Unocss from "unocss/vite";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import VueI18n from "@intlify/vite-plugin-vue-i18n";

export default defineConfig({
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  plugins: [
    vue({ reactivityTransform: true }),
    AutoImport({
      imports: [
        "vue",
        "vue-router",
        "vue-i18n",
        "vue/macros",
        "@vueuse/head",
        "@vueuse/core",
      ],
      dts: "src/auto-imports.d.ts",
      dirs: ["src/composables", "src/store"],
      vueTemplate: true,
      eslintrc: {
        enabled: true,
      },
    }),
    Components({
      extensions: ["vue"],
      // allow auto import and register components used in markdown
      include: [/\.vue$/, /\.vue\?vue/],
      dts: "src/components.d.ts",
    }),
    VitePWA(),
    VueI18n({
      runtimeOnly: true,
      compositionOnly: true,
      include: [path.resolve(__dirname, "locales/**")],
    }),
    Unocss(),
  ],
  test: {
    include: ["test/**/*.test.ts"],
    environment: "jsdom",
    deps: {
      inline: ["@vue", "@vueuse", "vue-demi"],
    },
  },
});
